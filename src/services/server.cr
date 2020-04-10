require "log"
require "file_utils"

Log.setup_from_env

class GitServer
  Log = ::Log.for(self)
  @contexted : HTTP::Server::Context
  @reqfile : String | Nil
  @rpc : String | Nil
  @dir : String
  @services : Array(Tuple(String, Proc((Bool | Nil)) | Proc((Bool | UInt64 | Nil)), String, String))

  def initialize(context)
    @contexted = context
    @contexted.response.reset
    @dir = ""
    @services = [
      {"POST", ->service_rpc, "(.*?)/git-upload-pack$", "upload-pack"},
      {"POST", ->service_rpc, "(.*?)/git-receive-pack$", "receive-pack"},

      {"GET", ->get_info_refs, "(.*?)/info/refs$", ""},
      {"GET", ->get_text_file, "(.*?)/HEAD$", ""},
      {"GET", ->get_text_file, "(.*?)/objects/info/alternates$", ""},
      {"GET", ->get_text_file, "(.*?)/objects/info/http-alternates$", ""},
      {"GET", ->get_info_packs, "(.*?)/objects/info/packs$", ""},
      {"GET", ->get_text_file, "(.*?)/objects/info/[^/]*$", ""},
      {"GET", ->get_loose_object, "(.*?)/objects/[0-9a-f]{2}/[0-9a-f]{38}$", ""},
      {"GET", ->get_pack_file, "(.*?)/objects/pack/pack-[0-9a-f]{40}\\.pack$", ""},
      {"GET", ->get_idx_file, "(.*?)/objects/pack/pack-[0-9a-f]{40}\\.idx$", ""},
    ]
  end

  def call
    cmdr, path, reqfile, rpc = match_routing
    @reqfile = reqfile if reqfile.is_a?(String)
    @rpc = rpc if rpc.is_a?(String) && !rpc.empty?
    cmd = cmdr if cmdr.is_a?(Proc)

    @dir = get_git_dir(path)
    if @dir.empty?
      Log.info { "GIT response - 404 - dir not exist - #{@dir}" }
    end

    render_not_found unless @dir
    render_not_found unless cmd

    if @dir && cmd
      Dir.cd(@dir) do
        cmd.call
      end
    end
  end

  # ---------------------------------
  # actual command handling functions
  # ---------------------------------

  def service_rpc
    return render_no_access unless has_access(@rpc, true)

    @contexted.response.status = HTTP::Status.new(200)
    @contexted.response.content_type = "application/x-git-%s-result" % @rpc
    Log.info { "GIT response - 200" }
    command = git_command("#{@rpc} --stateless-rpc #{@dir}")
    Process.run(command, shell: true, input: (@contexted.request.body || IO::Memory.new), output: @contexted.response)
    @contexted.response.close
    true
  end

  def get_info_refs
    service_name = get_service_type
    if has_access(service_name)
      cmd = git_command("#{service_name} --stateless-rpc --advertise-refs .")

      @contexted.response.status = HTTP::Status.new(200)
      @contexted.response.content_type = "application/x-git-%s-advertisement" % service_name
      hdr_nocache
      @contexted.response << pkt_write("# service=git-#{service_name}\n")
      @contexted.response << pkt_flush
      Process.run(cmd, shell: true, output: @contexted.response)
      @contexted.response.close
    else
      dumb_info_refs
    end
  end

  def dumb_info_refs
    update_server_info
    send_file(@reqfile, "text/plain; charset=utf-8") do
      hdr_nocache
    end
  end

  def get_info_packs
    # objects/info/packs
    send_file(@reqfile, "text/plain; charset=utf-8") do
      hdr_nocache
    end
  end

  def get_loose_object
    send_file(@reqfile, "application/x-git-loose-object") do
      hdr_cache_forever
    end
  end

  def get_pack_file
    send_file(@reqfile, "application/x-git-packed-objects") do
      hdr_cache_forever
    end
  end

  def get_idx_file
    send_file(@reqfile, "application/x-git-packed-objects-toc") do
      hdr_cache_forever
    end
  end

  def get_text_file
    send_file(@reqfile, "text/plain") do
      hdr_nocache
    end
  end

  # ------------------------
  # logic helping functions
  # ------------------------

  # some of this borrowed from the Rack::File implementation
  def send_file(reqfile, content_type)
    reqfile = File.join([@dir, reqfile])
    return render_not_found unless File.exists?(reqfile)

    @contexted.response.status = HTTP::Status.new(200)
    @contexted.response.headers.merge!({"Content-Type" => content_type, "Last-Modified" => File.info(reqfile).modification_time.to_s})

    yield

    size = File.size(reqfile)
    @contexted.response.content_length = size
    File.open(reqfile, "rb") do |file|
      IO.copy(file, @contexted.response)
    end
  end

  def get_git_dir(path)
    root = ENV["project_root"]? || File.join([FileUtils.pwd, "repositories"])
    path = File.join([root, path])
    return path if File.exists?(path) # TODO: check is a valid git directory
    ""
  end

  def get_service_type
    service_type = @contexted.request.query_params["service"]
    return false unless service_type
    return false if service_type[0, 4] != "git-"

    service_type.gsub("git-", "")
  end

  def match_routing
    cmd = nil
    path = nil
    @services.each do |line|
      method, handler, match, rpc = line
      next unless m = Regex.new(match).match(@contexted.request.path)
      return [->render_method_not_allowed, "", ""] if method != @contexted.request.method

      cmd = handler
      path = m[1]
      file = @contexted.request.path.sub(path + "/", "")
      return [cmd, path, file, rpc]
    end
    [] of String
  end

  def has_access(rpc, check_content_type = false)
    if check_content_type
      return false if @contexted.request.headers["Content-Type"] != "application/x-git-%s-request" % rpc
    end
    return false unless %w[upload-pack receive-pack].includes? rpc

    get_config_setting(rpc)
  end

  def get_config_setting(service_name) : Bool
    service_name = service_name.nil? || service_name.is_a?(Bool) ? Nil : service_name.gsub("-", "")
    setting = get_git_config("http.#{service_name}")
    return true if setting.empty?
    if service_name == "uploadpack"
      return setting != "false"
    else
      return setting == "true"
    end
  end

  def get_git_config(config_name)
    cmd = git_command("config #{config_name}")
    `#{cmd}`.chomp
  end

  def read_body
    if @contexted["HTTP_CONTENT_ENCODING"] =~ /gzip/
      Gzip::Reader.new(@contexted.request.body, true).read
    else
      @contexted.request.body.read
    end
  end

  def update_server_info
    cmd = git_command("update-server-info")
    `#{cmd}`
  end

  def git_command(command)
    git_bin = ENV["git_path"]? || "git"
    command = "#{git_bin} #{command}"
    command
  end

  # --------------------------------------
  # HTTP error response handling functions
  # --------------------------------------

  def render_method_not_allowed
    Log.info { "GIT response - not allowed" }
    if @contexted.request.version == "HTTP/1.1"
      @contexted.response.respond_with_status(HTTP::Status.new(405), "Method Not Allowed")
    else
      @contexted.response.respond_with_status(HTTP::Status.new(400), "Bad Request")
    end
  end

  def render_not_found
    Log.info { "GIT response - 404" }
    @contexted.response.respond_with_status(HTTP::Status.new(404), "Not Found")
  end

  def render_no_access
    @contexted.response.respond_with_status(HTTP::Status.new(403), "Forbidden")
  end

  # ------------------------------
  # packet-line handling functions
  # ------------------------------

  def pkt_flush
    "0000"
  end

  def pkt_write(str)
    (str.size + 4).to_s(base = 16).rjust(4, '0') + str
  end

  # ------------------------
  # header writing functions
  # ------------------------

  def hdr_nocache
    headers = {"Expires" => "Fri, 01 Jan 1980 00:00:00 GMT", "Pragma" => "no-cache", "Cache-Control" => "no-cache, max-age=0, must-revalidate"}
    @contexted.response.headers.merge!(headers)
  end

  def hdr_cache_forever
    now = Time.utc.to_unix
    headers = {"Date" => now.to_s, "Expires" => (now + 31_536_000).to_s, "Cache-Control" => "public, max-age=31536000"}
    @contexted.response.headers.merge!(headers)
  end
end
