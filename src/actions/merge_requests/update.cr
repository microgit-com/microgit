class Repositories::MergeRequests::Update < RepositoryAction
  put "/:namespace_slug/:repository_slug/merge_requests/:merge_request_id" do
    merge_request = MergeRequestQuery.find(merge_request_id)
    MergeRequestPolicy.update_forbidden?(merge_request, current_user, context)
    SaveMergeRequest.update(merge_request, params) do |operation, merge_request|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Show.with(@repository.not_nil!.namespace_slug, @repository.not_nil!.slug, merge_request.id)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, merge_request: merge_request, repository: @repository.not_nil!
      end
    end
  end
end
