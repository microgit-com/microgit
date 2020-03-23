class Commits::List < BrowserAction
  include Auth::AllowGuests
  include RepositoryHelper

  get "/:namespace_slug/:repository_slug/commits/:ref" do
    repository = check_access
    namespace = get_namespace
    begin
      repo = MicrogitGit.new(repository)
    rescue Exception
      raise Lucky::RouteNotFoundError.new(context)
    end

    target = Git::Branch.lookup(repo.raw, ref)

    html IndexPage, repo: repo, target: target.target_id, ref: ref, repository: repository, namespace: namespace
  end
end
