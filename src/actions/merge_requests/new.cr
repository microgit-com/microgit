class Repositories::MergeRequests::New < BrowserAction
  include RepositoryHelper
  get "/:namespace_slug/:repository_slug/merge_requests/new" do
    repository = check_access
    namespace = get_namespace
    html NewPage, operation: SaveMergeRequest.new, repository: repository, namespace: namespace
  end
end
