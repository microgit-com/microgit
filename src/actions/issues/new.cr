class Repositories::Issues::New < BrowserAction
  nested_route do
    repository = RepositoryQuery.find(repository_id)
    RepositoryPolicy.show?(repository, current_user, context)
    html NewPage, operation: SaveIssue.new, repository: repository
  end
end
