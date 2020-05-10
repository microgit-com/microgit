class Repositories::Issues::New < RepositoryAction

  get "/:namespace_slug/:repository_slug/issues/new" do
    namespace = get_namespace
    html NewPage, operation: CreateIssue.new(repo_id: @repository.not_nil!.id), repository: @repository.not_nil!, namespace: namespace
  end
end
