class Repositories::Edit < BrowserAction
  route do
    repository = RepositoryQuery.find(repository_id)
    html EditPage,
      operation: SaveRepository.new(repository),
      repository: repository
  end
end
