class Repositories::Show < BrowserAction
  route do
    html ShowPage, repository: RepositoryQuery.new.preload_user.find(repository_id)
  end
end
