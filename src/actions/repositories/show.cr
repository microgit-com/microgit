class Repositories::Show < BrowserAction
  route do
    repository = RepositoryQuery.new.preload_user.find(repository_id)
    html ShowPage, repository: repository, repo: Git::Repo.open(repository.git_path)
  end
end
