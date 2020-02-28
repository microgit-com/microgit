class Repositories::MergeRequests::Show < BrowserAction
  include RepositoryHelper
  get "/:namespace_slug/:repository_slug/merge_requests/:merge_request_id" do
    merge_request = MergeRequestQuery.find(merge_request_id)
    repository = check_access
    html ShowPage, merge_request: merge_request, repository: repository
  end
end
