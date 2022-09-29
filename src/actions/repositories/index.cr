class Repositories::Index < BrowserAction
  get "/repositories" do
    html IndexPage, repositories: RepositoryQuery.new.preload_user.preload_team.user_id(current_user.id)
  end
end
