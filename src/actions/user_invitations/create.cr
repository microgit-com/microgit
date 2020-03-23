class UserInvitations::Create < BrowserAction
  post "/teams/:team_id/user_invitations" do
    team = TeamQuery.find(team_id)
    TeamPolicy.invite_forbidden?(team, current_user, context)
    InviteUser.create(params, inviter_id: current_user.id, team_id: team.id) do |op, user_invitation|
      if user_invitation
        flash.success = "Yay!"
        redirect Namespaces::Members.with(team.slug)
      else
        flash.failure = ":("
        html NewPage, operation: op, team: team
      end
    end
  end
end
