class IssuePolicy < LuckyCan::BasePolicy

  can create, current_user do
    !current_user.nil?
  end

  can delete, issue, current_user do
    return false if issue.nil? || issue.repository.nil?
    return false if current_user.nil?

    repo = issue.repository

    return true if issue.author.id == current_user.id

    if repo.team
      repo.team.not_nil!.users!.map(&.id).includes?(current_user.not_nil!.id)
    else
      repo.user.not_nil!.id == current_user.not_nil!.id
    end
  end

  can update, issue, current_user do
    return false if issue.nil? || issue.repository.nil?
    return false if current_user.nil?

    repo = issue.repository

    return true if issue.author.id == current_user.id

    if repo.team
      repo.team.not_nil!.users!.map(&.id).includes?(current_user.not_nil!.id)
    else
      repo.user.id == current_user.not_nil!.id
    end
  end
end
