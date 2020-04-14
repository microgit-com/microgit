class Repositories::Edit < RepositoryAction
  get "/:namespace_slug/:repository_slug/edit" do
    html EditPage,
      operation: SaveRepository.new(@repository.not_nil!),
      repository: @repository.not_nil!
  end
end
