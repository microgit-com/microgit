class Teams::Delete < BrowserAction
  route do
    TeamQuery.find(team_id).delete
    flash.success = "Deleted the record"
    redirect Index
  end
end
