class MicrogitGit
  def initialize(@repo : Repository)
    @repo_git = Git::Repo.open(@repo.git_path)
  end

  def raw
    @repo_git
  end

  def last_commit
    return nil if @repo_git.empty?
    raw.last_commit
  end

  def size
    output = IO::Memory.new
    cmd = "du -sk #{@repo.git_path}"
    Process.run(cmd, shell: true, output: output)
    ((output.to_s.split.first.to_f / 1024)).round(2)
  end

  def root_ref
    refs = @repo_git.branches

    if refs["master"]
      "master"
    else
      refs[0]
    end
  end

  def commit_topic(commit_message : String) : String
    commit_message.split("\n\n").first
  end

  def commit_message(commit_message : String) : String
    commit_message.split("\n\n").second
  end

  def commit_count(ref = last_commit)
    return 0 if @repo_git.empty?
    return 0 if ref.nil?
    count = 0
    @repo_git.walk(ref.sha) do |c|
      count += 1
    end
    count
  end

  def find_file(file_path)
    return nil if tree.nil?
    return nil if @repo_git.empty?
    tree.try { |t| t.path(file_path) }
  end

  def find_file_blob(file_path = nil)
    return nil if @repo_git.empty?
    entry = find_file(file_path)
    return nil if entry.nil?
    Git::Blob.lookup(@repo_git, entry.oid)
  end

  def tree(ref = last_commit)
    return nil if ref.nil?
    return nil if @repo_git.empty?
    ref.tree
  end

  def log_by_walk(sha, options)
    walker = @repo_git.walk(sha)
    walker.to_a
  end

  def log_by_shell(sha, options)
    cmd = git_command("--git-dir=#{@repo.git_path} log")
    cmd += " -n #{options["limit"].to_i}"
    cmd += " --format=%H"
    cmd += " --skip=#{options.fetch("offset", 0).to_i}" if options.fetch("offset", false)
    cmd += " --follow" if options.fetch("follow", false)
    cmd += " --no-merges" if options.fetch("skip_merges", false)
    cmd += " --after=#{options.fetch("after", Time.utc).try { |t| t }}" if options.fetch("after", false)
    cmd += " --before=#{options.fetch("before", Time.utc).try { |t| t }}" if options.fetch("before", false)
    cmd += " #{sha}"
    cmd += " -- #{options["path"]}" if options.fetch("path", false)

    raw_output = IO::Memory.new

    Process.run(cmd, shell: true, output: raw_output)

    log = [] of Git::Commit
    output = raw_output.to_s

    output.split("\n").each do |c|
      next if c.empty?
      log << Git::Commit.lookup(@repo_git, c.strip)
    end

    return log
  end

  def last_for_path(ref, path = nil)
    log_by_shell(
      ref, {
      path:  path,
      limit: 1,
    }
    ).first
  end

  def sha_from_ref(ref)
    raw.rev_parse(ref).oid
  end

  def git_command(command)
    git_bin = ENV["git_path"]? || "git"
    command = "#{git_bin} #{command}"
    command
  end
end
