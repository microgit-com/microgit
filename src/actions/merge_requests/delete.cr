class Repositories::MergeRequests::Delete < BrowserAction
  nested_route do
    repository = RepositoryQuery.find(repository_id)
    RepositoryPolicy.show_not_found?(repository, current_user, context)
    MergeRequestQuery.find(merge_request_id).delete
    flash.success = "Deleted the record"
    redirect Index.with(repository.namespace_slug, repository.slug)
  end
end
