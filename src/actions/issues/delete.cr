class Repositories::Issues::Delete < RepositoryAction

  delete "/:namespace_slug/:repository_slug/issues/:issue_id" do
    issue = IssueQuery.find(issue_id)
    IssuePolicy.delete_forbidden?(issue, current_user, context)
    issue.delete
    flash.success = "Deleted the record"
    redirect Index.with(@repository.not_nil!.namespace_slug, @repository.not_nil!.slug)
  end
end
