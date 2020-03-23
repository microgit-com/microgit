class Repositories::Branches::Index < BrowserAction
  include Auth::AllowGuests
  include RepositoryHelper

  get "/:namespace_slug/:repository_slug/branches" do
    repository = check_access
    namespace = get_namespace
    begin
      repo = MicrogitGit.new(repository)
    rescue Exception
      raise Lucky::RouteNotFoundError.new(context)
    end

    branches = repo.raw.branches.each_name.to_a

    html IndexPage, repo: repo, branches: branches, repository: repository, namespace: namespace
  end
end
