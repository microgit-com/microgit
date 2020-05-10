class Repositories::MergeRequests::Create < RepositoryAction
  post "/:namespace_slug/:repository_slug/merge_requests" do
    CreateMergeRequest.create(params, repo_id: @repository.not_nil!.id, repository_id: @repository.not_nil!.id, author_id: current_user.id, status: MergeRequest::AvramStatus.new(:open)) do |operation, merge_request|
      if merge_request
        flash.success = "The record has been saved"
        redirect Show.with(@repository.not_nil!.namespace_slug, @repository.not_nil!.slug, merge_request.scoped_id)
      else
        flash.failure = "It looks like the form is not valid"
        html NewPage, operation: operation, merge_request: merge_request, repository: @repository.not_nil!, namespace: @namespace.not_nil!
      end
    end
  end
end
