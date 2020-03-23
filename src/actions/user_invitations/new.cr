class UserInvitations::New < BrowserAction

  get "/teams/:team_id/user_invitations/new" do
    team = TeamQuery.find(team_id)
    TeamPolicy.invite_forbidden?(team, current_user, context)
    html NewPage, operation: InviteUser.new, team: team
  end
end
