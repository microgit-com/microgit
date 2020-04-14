class Commits::List < RepositoryAction
  include Auth::AllowGuests

  get "/:namespace_slug/:repository_slug/commits/:ref" do
    begin
      repo = MicrogitGit.new(@repository.not_nil!)
    rescue Exception
      raise Lucky::RouteNotFoundError.new(context)
    end

    target = Git::Branch.lookup(repo.raw, ref)

    html IndexPage, repo: repo, target: target.target_id, ref: ref, repository: @repository.not_nil!, namespace: @namespace.not_nil!
  end
end
