class Repositories::Issues::Delete < BrowserAction
  nested_route do
    repository = RepositoryQuery.find(repository_id)
    IssueQuery.find(issue_id).delete
    flash.success = "Deleted the record"
    redirect Index.with(repository.user.slug, repository.slug)
  end
end
