class Teams::Update < BrowserAction
  route do
    team = TeamQuery.find(team_id)
    SaveTeam.update(team, params) do |operation, team|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Show.with(team.id)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, team: team
      end
    end
  end
end
