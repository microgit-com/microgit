class Commits::Index < RepositoryAction
  include Auth::AllowGuests

  get "/:namespace_slug/:repository_slug/commits" do
    begin
      repo = MicrogitGit.new(@repository.not_nil!)
    rescue Exception
      raise Lucky::RouteNotFoundError.new(context)
    end

    target = Git::Branch.lookup(repo.raw, "master")

    html IndexPage, repo: repo, target: target.target_id, ref: "master", repository: @repository.not_nil!, namespace: @namespace.not_nil!
  end
end
