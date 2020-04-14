class Repositories::Issues::Update < RepositoryAction
  put "/:namespace_slug/:repository_slug/issues/:issue_id" do
    issue = IssueQuery.find(issue_id)

    IssuePolicy.update_forbidden?(issue, current_user, context)

    SaveIssue.update(issue, params) do |operation, issue|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Show.with(@repository.not_nil!.namespace_slug, @repository.not_nil!.slug, issue.id)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, issue: issue, repository: @repository.not_nil!
      end
    end
  end
end
