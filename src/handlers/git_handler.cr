class HTTP::GitHandler
  include HTTP::Handler

  def call(context)
    if /[-\/\w\.]+\.git/.match(context.request.path)
      if context.request.headers.has_key?("Authorization")
        _, enc = context.request.headers["Authorization"].split
        username, password = Base64.decode_string(enc).split(":")
        if authorized?(username, password)
          context.request.headers.delete("Authorization")
          git = GitServer.new(context)
          return git.call
        end
      end
      context.response.headers.add("WWW-Authenticate", "Basic realm=\"User Visible Realm\"")
      context.response.status = HTTP::Status.new(401)
      context.response.puts "Forbidden"
      context.response.close
    else
      call_next(context)
    end
  end

  private def authorized?(username, password)
    SignInUserGit.new(Avram::Params.new({"username" => username, "password" => password})).submit do |operation, authenticated_user|
      return true if authenticated_user
      return false unless authenticated_user
    end
  end

end
