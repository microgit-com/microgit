class RepositoryPolicy
  def self.show?(namespace : Namespace, repository : Repository, current_user : User | Nil)
  end

  def self.show?(repository : Repository, current_user : User | Nil, context)
    unless can_access_repo?(repository, current_user)
      raise Lucky::RouteNotFoundError.new(context)
    end
  rescue Exception
    raise Lucky::RouteNotFoundError.new(context)
  end

  def self.can_access_repo?(repository : Repository, current_user : User | Nil)
    return false if current_user.nil? && repository.privated
    if repository.team
      !repository.team.not_nil!.users!.find { |u| u.id == current_user.not_nil!.id }.nil? || !repository.privated
    elsif repository.user
      repository.user.not_nil!.id == current_user.not_nil!.id || !repository.privated
    else
      false
    end
  end

  def self.repo_member?(repository : Repository, current_user : User | Nil, method : String)
    return false if current_user.nil? && repository.privated

    if repository.team && method == "POST"
      !repository.team.not_nil!.users!.find { |u| u.id == current_user.not_nil!.id }.nil?
    elsif repository.user && method == "POST"
      repository.user.not_nil!.id == current_user.not_nil!.id
    elsif repository.team && method == "GET"
      !repository.team.not_nil!.users!.find { |u| u.id == current_user.not_nil!.id }.nil? || !repository.privated
    elsif repository.user && method == "GET"
      repository.user.not_nil!.id == current_user.not_nil!.id || !repository.privated
    else
      false
    end
  end
end
