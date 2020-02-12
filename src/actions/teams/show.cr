class Teams::Show < BrowserAction
  route do
    html ShowPage, team: TeamQuery.new.preload_namespace.find(team_id)
  end
end
