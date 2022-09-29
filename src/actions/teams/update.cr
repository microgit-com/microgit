class Teams::Update < BrowserAction
  put "/teams/:team_id" do
    team = TeamQuery.find(team_id)
    TeamPolicy.update_forbidden?(team, current_user, context)
    UpdateTeam.update(team, params) do |operation, team|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Namespaces::Show.with(team.slug)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, team: team
      end
    end
  end
end
