class Repositories::Issues::Index < RepositoryAction
  include Auth::AllowGuests

  get "/:namespace_slug/:repository_slug/issues" do
    html IndexPage, issues: IssueQuery.new.preload_author.repository_id(@repository.not_nil!.id), repository: @repository.not_nil!, namespace: @namespace.not_nil!
  end
end
