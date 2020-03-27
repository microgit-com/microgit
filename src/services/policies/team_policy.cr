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
    team.users!.map(&.id).includes?(current_user.not_nil!.id)
  end
end
