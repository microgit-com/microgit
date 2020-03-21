class Teams::Index < BrowserAction
  route do
    html IndexPage, teams: current_user.teams!
  end
end
