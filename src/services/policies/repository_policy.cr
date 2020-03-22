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
      !repository.team.not_nil!.users!.map(&.id).includes?(current_user.not_nil!.id) || !repository.privated
    elsif repository.user
      repository.user.not_nil!.id == current_user.not_nil!.id || !repository.privated
    else
      false
    end
  end

  def self.repo_member?(repository : Repository, current_user : User | Nil, method : String)
    return false if current_user.nil? && repository.privated
    return false if current_user.nil? && !repository.privated && method == "POST"
    return true if current_user.nil? && !repository.privated && method == "GET"

    if repository.team && method == "POST" && !current_user.nil?
      !repository.team.not_nil!.users!.map(&.id).includes?(current_user.not_nil!.id)
    elsif repository.user && method == "POST" && !current_user.nil?
      repository.user.not_nil!.id == current_user.not_nil!.id
    elsif repository.team && method == "GET" && !current_user.nil?
      !repository.team.not_nil!.users!.map(&.id).includes?(current_user.not_nil!.id) || !repository.privated
    elsif repository.user && method == "GET" && !current_user.nil?
      repository.user.not_nil!.id == current_user.not_nil!.id || !repository.privated
    else
      false
    end
  end
end
