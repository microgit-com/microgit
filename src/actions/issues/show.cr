class Repositories::Issues::Show < BrowserAction
  nested_route do
    html ShowPage, issue: IssueQuery.new.find(issue_id), repository: RepositoryQuery.find(repository_id)
  end
end
