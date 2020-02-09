class Repositories::Issues::Index < BrowserAction
  nested_route do
    repository = RepositoryQuery.find(repository_id)
    html IndexPage, issues: IssueQuery.new, repository: repository
  end
end
