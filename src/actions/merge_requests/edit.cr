class Repositories::MergeRequests::Edit < BrowserAction
  nested_route do
    merge_request = MergeRequestQuery.find(merge_request_id)
    repository = RepositoryQuery.find(repository_id)
    RepositoryPolicy.show_not_found?(repository, current_user, context)
    html EditPage,
      operation: SaveMergeRequest.new(merge_request),
      merge_request: merge_request,
      repository: repository
  end
end
