class Repositories::Branches::Show < BrowserAction
  include Auth::AllowGuests
  include RepositoryHelper

  get "/:namespace_slug/:repository_slug/branches/:branch_name" do
    repository = check_access
    begin
      repo = MicrogitGit.new(repository)
    rescue Exception
      raise Lucky::RouteNotFoundError.new(context)
    end

    target_branch = Git::Branch.lookup(repo.raw, branch_name)
    target_commit = Git::Commit.lookup(repo.raw, target_branch.target_id)
    tree = target_commit.tree


    html ShowPage, repo: repo, tree: tree, repository: repository, branch_name: branch_name
  end
end
