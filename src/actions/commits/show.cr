class Commits::Show < RepositoryAction
  include Auth::AllowGuests

  get "/:namespace_slug/:repository_slug/commits/:branch_name/:sha" do
    begin
      repo = MicrogitGit.new(@repository.not_nil!)
    rescue Exception
      raise Lucky::RouteNotFoundError.new(context)
    end

    commit = Git::Commit.lookup(repo.raw, sha)

    #revwalk = Git::RevWalk.new(repo.raw)
    #revwalk.push(sha)
    #revwalk.sorting(LibGit::Sort::Topological)
    #diffed = revwalk.next
    diff = commit.parent.diff(commit)



    html ShowPage, repo: repo, commit: commit, repository: @repository.not_nil!, diff: diff
  end
end
