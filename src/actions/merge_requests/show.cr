class Repositories::MergeRequests::Show < BrowserAction
  include RepositoryHelper
  get "/:namespace_slug/:repository_slug/merge_requests/:merge_request_id" do
    merge_request = MergeRequestQuery.new.preload_author.find(merge_request_id)
    repository = check_access
    namespace = get_namespace
    comments = ActivityForItemsQuery.new.preload_user.merge_request_id(merge_request_id)
    html ShowPage, operation: SaveActivityForItems.new, merge_request: merge_request, repository: repository, namespace: namespace, comments: comments
  end
end
