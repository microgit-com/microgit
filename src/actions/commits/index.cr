class Commits::Index < BrowserAction
  include RepositoryHelper

  get "/:namespace_slug/:repository_slug/commits" do
    repository = check_access
    namespace = get_namespace
    begin
      repo = MicrogitGit.new(repository)
    rescue Exception
      raise Lucky::RouteNotFoundError.new(context)
    end

    html IndexPage, repo: repo, repository: repository, namespace: namespace
  end
end
