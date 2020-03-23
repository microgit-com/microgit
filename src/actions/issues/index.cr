class Repositories::Issues::Index < BrowserAction
  include Auth::AllowGuests
  include ::RepositoryHelper

  get "/:namespace_slug/:repository_slug/issues" do
    repository = check_access
    namespace = get_namespace
    html IndexPage, issues: IssueQuery.new.preload_author.repository_id(repository.id), repository: repository, namespace: namespace
  end
end
