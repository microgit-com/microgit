class Repositories::MergeRequests::Index < BrowserAction
  include RepositoryHelper
  get "/:namespace_slug/:repository_slug/merge_requests" do
    repository = check_access
    namespace = get_namespace
    html IndexPage, merge_requests: MergeRequestQuery.new.preload_author, repository: repository, namespace: namespace
  end
end
