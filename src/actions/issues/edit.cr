class Repositories::Issues::Edit < BrowserAction
  nested_route do
    issue = IssueQuery.find(issue_id)
    repository = RepositoryQuery.find(repository_id)
    html EditPage,
      operation: SaveIssue.new(issue),
      issue: issue,
      repository: repository
  end
end
