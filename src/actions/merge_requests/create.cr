class Repositories::MergeRequests::Create < RepositoryAction
  post "/:namespace_slug/:repository_slug/merge_requests" do
    repository = get_repository
    namespace = get_namespace
    SaveMergeRequest.create(params, repository_id: repository.id, author_id: current_user.id, status: MergeRequest::AvramStatus.new(:open)) do |operation, merge_request|
      if merge_request
        flash.success = "The record has been saved"
        redirect Show.with(repository.namespace_slug, repository.slug, merge_request.id)
      else
        flash.failure = "It looks like the form is not valid"
        html NewPage, operation: operation, merge_request: merge_request, repository: repository, namespace: namespace
      end
    end
  end
end
