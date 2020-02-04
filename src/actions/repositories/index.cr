class Repositories::Index < BrowserAction
  route do
    html IndexPage, repositories: RepositoryQuery.new.preload_user.user_id(current_user.id)
  end
end
