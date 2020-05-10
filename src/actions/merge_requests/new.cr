class Repositories::MergeRequests::New < RepositoryAction

  get "/:namespace_slug/:repository_slug/merge_requests/new" do
    html NewPage, operation: CreateMergeRequest.new(repo_id: @repository.not_nil!.id), repository: @repository.not_nil!, namespace: @namespace.not_nil!
  end
end
