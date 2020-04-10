class Teams::Edit < BrowserAction
  route do
    team = TeamQuery.find(team_id)
    TeamPolicy.update_forbidden?(team, current_user, context)
    html EditPage,
      operation: UpdateTeam.new(team),
      team: team
  end
end
