class Repositories::Issues::Index < BrowserAction
  nested_route do
    repository = RepositoryQuery.find(repository_id)
    html IndexPage, issues: IssueQuery.new.preload_author, repository: repository
  end
end
