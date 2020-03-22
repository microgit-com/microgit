class Teams::Edit < BrowserAction
  route do
    team = TeamQuery.find(team_id)
    TeamPolicy.update?(team, current_user, context)
    html EditPage,
      operation: SaveTeam.new(team),
      team: team
  end
end
