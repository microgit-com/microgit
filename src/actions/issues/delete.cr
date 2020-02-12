class Repositories::Issues::Delete < BrowserAction
  nested_route do
    repository = RepositoryQuery.find(repository_id)
    RepositoryPolicy.show?(repository, current_user, context)
    IssueQuery.find(issue_id).delete
    flash.success = "Deleted the record"
    redirect Index.with(repository.namespace_slug, repository.slug)
  end
end
