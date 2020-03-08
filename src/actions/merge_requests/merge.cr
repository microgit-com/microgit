class Repositories::MergeRequests::Merge < BrowserAction
  include RepositoryHelper
  get "/:namespace_slug/:repository_slug/merge_requests/:merge_request_id/merge" do
    repository = check_access

    redirect Show.with(repository.namespace_slug, repository.slug, merge_request_id)

  end
end
