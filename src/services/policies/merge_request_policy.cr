class MergeRequestPolicy < LuckyCan::BasePolicy

  can create, current_user do
    !current_user.nil?
  end

  can update, merge_request, current_user do
    return false if merge_request.nil? || merge_request.repository.nil?
    return false if current_user.nil?
    return true if merge_request.author.id == current_user.id

    repo = merge_request.repository

    if repo.team
      repo.team.not_nil!.users!.map(&.id).includes?(current_user.not_nil!.id)
    else
      repo.user.not_nil!.id == current_user.not_nil!.id
    end
  end

  can delete, merge_request, current_user do
    return false if merge_request.nil? || merge_request.repository.nil?
    return false if current_user.nil?
    return true if merge_request.author.id == current_user.id

    repo = merge_request.repository

    if repo.team
      repo.team.not_nil!.users!.map(&.id).includes?(current_user.not_nil!.id)
    else
      repo.user.not_nil!.id == current_user.not_nil!.id
    end
  end
end
