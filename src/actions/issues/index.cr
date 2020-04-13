class Repositories::Issues::Index < RepositoryAction
  include Auth::AllowGuests

  get "/:namespace_slug/:repository_slug/issues" do
    repository = get_repository
    namespace = get_namespace
    html IndexPage, issues: IssueQuery.new.preload_author.repository_id(repository.id), repository: repository, namespace: namespace
  end
end
