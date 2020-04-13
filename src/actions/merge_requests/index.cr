class Repositories::MergeRequests::Index < RepositoryAction
  include Auth::AllowGuests

  get "/:namespace_slug/:repository_slug/merge_requests" do
    repository = get_repository
    namespace = get_namespace
    html IndexPage, merge_requests: MergeRequestQuery.new.preload_author, repository: repository, namespace: namespace
  end
end
