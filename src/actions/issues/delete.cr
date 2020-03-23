class Repositories::Issues::Delete < BrowserAction
  include ::RepositoryHelper

  delete "/:namespace_slug/:repository_slug/issues/:issue_id" do
    repository = check_access
    issue = IssueQuery.find(issue_id)
    IssuePolicy.delete_forbidden?(issue, current_user, context)
    issue.delete
    flash.success = "Deleted the record"
    redirect Index.with(repository.namespace_slug, repository.slug)
  end
end
