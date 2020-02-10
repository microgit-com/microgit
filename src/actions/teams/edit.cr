class Teams::Edit < BrowserAction
  route do
    team = TeamQuery.find(team_id)
    html EditPage,
      operation: SaveTeam.new(team),
      team: team
  end
end
