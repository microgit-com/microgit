class Repositories::Edit < RepositoryAction
  get "/:namespace_slug/:repository_slug/edit" do
    repository = get_repository
    html EditPage,
      operation: SaveRepository.new(repository),
      repository: repository
  end
end
