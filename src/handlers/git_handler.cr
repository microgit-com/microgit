class HTTP::GitHandler
  include HTTP::Handler

  def call(context)
    if /[-\/\w\.]+\.git/.match(context.request.path)
      namespace, repo = get_repo(context.request.path)
      if namespace.nil? || repo.nil?
        context.response.status = HTTP::Status.new(404)
        context.response.puts "Not Found"
        context.response.close
        return
      end

      user = get_user(context)
      return forbidden_render(context) unless RepositoryPolicy.repo_member?(repo, user, context.request.method)

      context.request.headers.delete("Authorization")
      git = GitServer.new(context)
      return git.call
    else
      call_next(context)
    end
  end

  private def get_repo(path)
    namespace, repo, git_type = namespace_repo_from_path(path)
    return nil, nil if namespace.nil? || repo.nil? || namespace.empty? || repo.empty?
    namespace_model = NamespaceQuery.new.preload_user.preload_team.slug(namespace.not_nil!).first
    return nil, nil if namespace_model.nil?
    repo_model = if namespace_model.item.is_a?(Team)
      RepositoryQuery.new.preload_team.preload_user.team_id(namespace_model.team_id.not_nil!).slug(repo.not_nil!).first
    elsif namespace_model.item.is_a?(User)
      RepositoryQuery.new.preload_team.preload_user.user_id(namespace_model.user_id.not_nil!).slug(repo.not_nil!).first
    end
    return nil, nil if repo_model.nil?
    return namespace_model, repo_model
  rescue Avram::RecordNotFoundError
    return nil, nil
  end

  private def get_user(context)
    if context.request.headers.has_key?("Authorization")
      _, enc = context.request.headers["Authorization"].split
      username, password = Base64.decode_string(enc).split(":")
      SignInUserGit.new(Avram::Params.new({"username" => username, "password" => password})).submit do |operation, authenticated_user|
        return authenticated_user
      end
    end
    return nil
  end

  private def namespace_repo_from_path(path)
    match = /^\/(?<namespace>[\w\-\.]+)\/(?<repo>[\w\-]+).git((.*=(?<type>[\w\-]+$))?)/.match(path)
    return "", "", "" if match.nil?
    namespace = match.not_nil!["namespace"]? || ""
    repo_name = match.not_nil!["repo"]? || ""
    git_type = match.not_nil!["type"]? || ""
    return namespace, repo_name, git_type
  end

  private def forbidden_render(context)
    context.response.headers.add("WWW-Authenticate", "Basic realm=\"User Visible Realm\"")
    context.response.status = HTTP::Status.new(401)
    context.response.puts "Forbidden"
    context.response.close
    return context
  end
end
