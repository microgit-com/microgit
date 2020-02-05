class Repositories::Edit < BrowserAction
  route do
    repository = RepositoryQuery.new.preload_user.find(repository_id)
    html EditPage,
      operation: SaveRepository.new(repository),
      repository: repository
  end
end
