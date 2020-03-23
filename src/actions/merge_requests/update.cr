class Repositories::MergeRequests::Update < BrowserAction
  nested_route do
    merge_request = MergeRequestQuery.find(merge_request_id)
    repository = RepositoryQuery.find(repository_id)
    RepositoryPolicy.show_not_found?(repository, current_user, context)
    SaveMergeRequest.update(merge_request, params) do |operation, merge_request|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Show.with(repository.namespace_slug, repository.slug, merge_request.id)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, merge_request: merge_request, repository: repository
      end
    end
  end
end
