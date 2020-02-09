class Repositories::Issues::Update < BrowserAction
  nested_route do
    issue = IssueQuery.find(issue_id)
    repository = RepositoryQuery.find(repository_id)
    SaveIssue.update(issue, params) do |operation, issue|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Show.with(repository_id, issue.id)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, issue: issue, repository: repository
      end
    end
  end
end
