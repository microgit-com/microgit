class Repositories::Index < BrowserAction
  route do
    html IndexPage, repositories: RepositoryQuery.new.preload_user.preload_team.user_id(current_user.id)
  end
end
