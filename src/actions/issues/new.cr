class Repositories::Issues::New < RepositoryAction

  get "/:namespace_slug/:repository_slug/issues/new" do
    namespace = get_namespace
    html NewPage, operation: SaveIssue.new, repository: @repository.not_nil!, namespace: namespace
  end
end
