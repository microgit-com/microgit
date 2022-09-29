class Teams::Index < BrowserAction
  get "/teams" do
    html IndexPage, teams: current_user.teams!
  end
end
