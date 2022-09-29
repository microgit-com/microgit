class Teams::Delete < BrowserAction
  delete "/teams/:team_id" do
    team = TeamQuery.find(team_id)
    TeamPolicy.delete_forbidden?(team, current_user, context)
    team.delete
    flash.success = "Deleted the record"
    redirect Index
  end
end
