class Repositories::Issues::New < BrowserAction
  nested_route do
    repository = RepositoryQuery.find(repository_id)
    html NewPage, operation: SaveIssue.new,repository: repository
  end
end
