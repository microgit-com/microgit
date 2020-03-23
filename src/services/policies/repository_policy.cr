class RepositoryPolicy < BasePolicy
  def self.show?(namespace : Namespace, repository : Repository, current_user : User | Nil)
  end

  def self.show?(repository : Repository, current_user : User | Nil, context)
    not_found(context) do
      can_access_repo?(repository, current_user)
    end
  end

  def self.update?(repository : Repository, current_user : User | Nil)

    return false if current_user.nil?

    if repository.team
      !repository.team.not_nil!.users!.map(&.id).includes?(current_user.not_nil!.id)
    else
      repository.user.not_nil!.id == current_user.not_nil!.id
    end
  end

  def self.can_access_repo?(repository : Repository, current_user : User | Nil)
    return false if current_user.nil? && repository.privated
    if repository.team && !current_user.nil?
      !repository.team.not_nil!.users!.map(&.id).includes?(current_user.not_nil!.id) || !repository.privated
    elsif repository.user && !current_user.nil?
      repository.user.not_nil!.id == current_user.not_nil!.id || !repository.privated
    elsif !repository.privated && current_user.nil?
      true
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
