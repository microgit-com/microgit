class Repositories::MergeRequests::Merge < RepositoryAction
  get "/:namespace_slug/:repository_slug/merge_requests/:merge_request_id/merge" do
    merge_request = MergeRequestQuery.new.preload_author.find(merge_request_id)
    begin
      repo = MicrogitGit.new(@repository.not_nil!)
    rescue Exception
      raise Lucky::RouteNotFoundError.new(context)
    end

    repo.merge_branch(merge_request, current_user)

    SaveMergeRequest.update(merge_request, status: MergeRequest::AvramStatus.new(:merged)) do |operation, merge_request|
     if operation.saved?
       flash.success = "The record has been updated"
       redirect Show.with(@repository.not_nil!.namespace_slug, @repository.not_nil!.slug, merge_request.id)
     else
       flash.failure = "It looks like the form is not valid"
       redirect Show.with(@repository.not_nil!.namespace_slug, @repository.not_nil!.slug, merge_request_id)
     end
   end
  end
end
