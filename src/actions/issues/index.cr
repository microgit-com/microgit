class Repositories::Issues::Index < BrowserAction
  include ::RepositoryHelper

  get "/:namespace_slug/:repository_slug/issues" do
    repository = check_access
    html IndexPage, issues: IssueQuery.new.preload_author.repository_id(repository.id), repository: repository
  end
end
