class Teams::Show < BrowserAction
  route do
    html ShowPage, team: TeamQuery.find(team_id)
  end
end
