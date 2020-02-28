class Repositories::Edit < BrowserAction
  include RepositoryHelper
  get "/:namespace_slug/:repository_slug/edit" do
    repository = check_access
    html EditPage,
      operation: SaveRepository.new(repository),
      repository: repository
  end
end
