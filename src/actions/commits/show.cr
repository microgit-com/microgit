class Commits::Show < BrowserAction
  include RepositoryHelper

  get "/:namespace_slug/:repository_slug/commits/:branch_name/:sha" do
    repository = check_access
    begin
      repo = MicrogitGit.new(repository)
    rescue Exception
      raise Lucky::RouteNotFoundError.new(context)
    end

    commit = Git::Commit.lookup(repo.raw, sha)
    diff = commit.diff

    html ShowPage, repo: repo, commit: commit, repository: repository, diff: diff
  end
end
