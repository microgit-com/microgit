class Repositories::MergeRequests::New < RepositoryAction

  get "/:namespace_slug/:repository_slug/merge_requests/new" do
    repository = get_repository
    namespace = get_namespace
    html NewPage, operation: SaveMergeRequest.new, repository: repository, namespace: namespace
  end
end
