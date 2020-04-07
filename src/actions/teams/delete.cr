class Teams::Delete < BrowserAction
  route do
    team = TeamQuery.find(team_id)
    TeamPolicy.delete_forbidden?(team, current_user, context)
    team.delete
    flash.success = "Deleted the record"
    redirect Index
  end
end
