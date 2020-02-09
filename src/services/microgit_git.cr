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
    ((File.size(@repo.git_path).to_f / 1024) / 1024).round(2)
  end

  def root_ref
    refs = @repo_git.branches

    if refs["master"]
      "master"
    else
      refs[0]
    end
  end

  def commit_count(ref = last_commit)
    return 0 if @repo_git.empty?
    return 0 if ref.nil?
    walker = @repo_git.walk(ref.sha)
    count = 0
    walker.each do |c|
      count += 1
      next
    end
    count
  end

  def find_file(file_path)
    return nil if tree.nil?
    return nil if @repo_git.empty?
    tree.try {|t| t.path(file_path) }
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

  def log(options)
    default_options = {
      limit: 10,
      offset: 0,
      path: nil,
      follow: false,
      skip_merges: false,
      disable_walk: false,
      after: nil,
      before: nil
    }

    options = default_options.merge(options)
    options[:limit] ||= 0
    options[:offset] ||= 0
    actual_ref = options[:ref] || root_ref
    sha = sha_from_ref(actual_ref)

    log_by_walk(sha, options)
  end

  def log_by_walk(sha, options)
   raw.walk.to_a
 end

  def sha_from_ref(ref)
    raw.rev_parse(ref).oid
  end

end
