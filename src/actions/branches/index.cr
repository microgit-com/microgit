class Repositories::Branches::Index < RepositoryAction
  include Auth::AllowGuests

  get "/:namespace_slug/:repository_slug/branches" do
    begin
      repo = MicrogitGit.new(@repository.not_nil!)
    rescue Exception
      raise Lucky::RouteNotFoundError.new(context)
    end

    branches = repo.raw.branches.each_name.to_a

    html IndexPage, repo: repo, branches: branches, repository: @repository.not_nil!, namespace: @namespace.not_nil!
  end
end
