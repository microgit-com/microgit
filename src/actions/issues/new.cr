class Repositories::Issues::New < BrowserAction
  include RepositoryHelper

  get "/:namespace_slug/:repository_slug/issues/new" do
    repository = check_access
    namespace = get_namespace
    html NewPage, operation: SaveIssue.new, repository: repository, namespace: namespace
  end
end
