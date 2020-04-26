class HTTP::FileGlobHandler
  include HTTP::Handler

  def call(context)
    return call_next(context) unless glob_url?(context.request.path)

    namespace, repo, branch, path = namespace_repo_from_path(context.request.path)

    action = Repositories::Blobs::Show.new(context, {"namespace_slug" => namespace, "repository_slug" => repo, "branch_name" => branch, "path" => path})
    Lucky::Log.dexter.debug { {handled_by: action.class.name.to_s} }
    action.perform_action
  end

  private def glob_url?(path)
    /^\/(?<namespace>[\w\-\.]+)\/(?<repo>[\w\-]+)\/blob\/(?<branch>[\w\-]+)\/(?<path>[\w\-].*)/.match(path)
  end

  private def namespace_repo_from_path(path)
    match = /^\/(?<namespace>[\w\-\.]+)\/(?<repo>[\w\-]+)\/blob\/(?<branch>[\w\-]+)\/(?<path>[\w\-].*)/.match(path)
    return "", "", "", "" if match.nil?
    namespace = match.not_nil!["namespace"]? || ""
    repo_name = match.not_nil!["repo"]? || ""
    branch = match.not_nil!["branch"]? || ""
    path = match.not_nil!["path"]? || ""
    return namespace, repo_name, branch, path
  end
end
