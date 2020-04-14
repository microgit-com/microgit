class Repositories::Branches::Show < RepositoryAction
  include Auth::AllowGuests

  get "/:namespace_slug/:repository_slug/branches/:branch_name" do
    begin
      repo = MicrogitGit.new(@repository.not_nil!)
    rescue Exception
      raise Lucky::RouteNotFoundError.new(context)
    end

    target_branch = Git::Branch.lookup(repo.raw, branch_name)
    target_commit = Git::Commit.lookup(repo.raw, target_branch.target_id)
    tree = target_commit.tree


    html ShowPage, repo: repo, tree: tree, repository: @repository.not_nil!, branch_name: branch_name
  end
end
