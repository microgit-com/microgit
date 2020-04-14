class Repositories::MergeRequests::Edit < RepositoryAction
  get "/:namespace_slug/:repository_slug/merge_requests/:merge_request_id/edit" do
    merge_request = MergeRequestQuery.find(merge_request_id)
    
    MergeRequestPolicy.update_forbidden?(merge_request, current_user, context)

    html EditPage,
      operation: SaveMergeRequest.new(merge_request),
      merge_request: merge_request,
      repository: @repository.not_nil!
  end
end
