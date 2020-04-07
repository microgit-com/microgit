class TeamPolicy < LuckyCan::BasePolicy

  can show, team, current_user do
    true
  end

  can update, team, current_user do
    return false if current_user.nil?
    team.users!.map(&.id).includes?(current_user.not_nil!.id)
  end

  can invite, team, current_user do
    return false if current_user.nil?
    team.users!.map(&.id).includes?(current_user.not_nil!.id)
  end

  can list_private_repos, team, current_user do
    return false if current_user.nil?
    team.users!.map(&.id).includes?(current_user.not_nil!.id)
  end

  can see_members, team, current_user do
    return false if current_user.nil?
    team.users!.map(&.id).includes?(current_user.not_nil!.id)
  end

  can delete, team, current_user do
    return false if current_user.nil?
    team.users!.map(&.id).includes?(current_user.not_nil!.id) && team.team_members!.find { |m| m.user_id == current_user.not_nil!.id }.not_nil!.role.value == TeamMembers::Role::Admin
  end
end
