class Repositories::MergeRequests::Delete < RepositoryAction
  delete "/:namespace_slug/:repository_slug/merge_requests/:merge_request_id" do
    merge_request = MergeRequestQuery.find(merge_request_id)

    MergeRequestPolicy.delete_forbidden?(merge_request, current_user, context)

    merge_request.delete
    flash.success = "Deleted the merge request"
    redirect Index.with(@repository.not_nil!.namespace_slug, @repository.not_nil!.slug)
  end
end
