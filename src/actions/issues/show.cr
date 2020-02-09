class Repositories::Issues::Show < BrowserAction
  nested_route do
    issue = IssueQuery.new.preload_repository.preload_author.preload_assignee.find(issue_id)
    html ShowPage, issue: issue, repository: issue.repository
  end
end
