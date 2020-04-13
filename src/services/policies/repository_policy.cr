class RepositoryPolicy < LuckyCan::BasePolicy

  can(show, repository, current_user) do
    return false if repository.nil?
    return false if current_user.nil? && repository.not_nil!.privated
    if repository.team && !current_user.nil?
      repository.team.not_nil!.users!.map(&.id).includes?(current_user.not_nil!.id) || !repository.privated
    elsif repository.user && !current_user.nil?
      repository.user.not_nil!.id == current_user.not_nil!.id || !repository.privated
    elsif !repository.privated && current_user.nil?
      true
    else
      false
    end
  end

  can delete, repository, current_user do
    return false if current_user.nil?

    if repository.team
      repository.team.not_nil!.users!.map(&.id).includes?(current_user.not_nil!.id) && repository.team.not_nil!.team_members!.find { |m| m.user_id == current_user.not_nil!.id }.not_nil!.role.value == TeamMembers::Role::Admin
    else
      repository.user.not_nil!.id == current_user.not_nil!.id
    end
  end

  can update, repository, current_user do
    return false if current_user.nil?

    if repository.team
      repository.team.not_nil!.users!.map(&.id).includes?(current_user.not_nil!.id)
    else
      repository.user.not_nil!.id == current_user.not_nil!.id
    end
  end

  can(repo_member, repository, current_user, method) do
    return false if current_user.nil? && repository.privated
    return false if current_user.nil? && !repository.privated && method == "POST"
    return true if current_user.nil? && !repository.privated && method == "GET"

    if repository.team && method == "POST" && !current_user.nil?
      repository.team.not_nil!.users!.map(&.id).includes?(current_user.not_nil!.id)
    elsif repository.user && method == "POST" && !current_user.nil?
      repository.user.not_nil!.id == current_user.not_nil!.id
    elsif repository.team && method == "GET" && !current_user.nil?
      repository.team.not_nil!.users!.map(&.id).includes?(current_user.not_nil!.id) || !repository.privated
    elsif repository.user && method == "GET" && !current_user.nil?
      repository.user.not_nil!.id == current_user.not_nil!.id || !repository.privated
    else
      false
    end
  end
end
