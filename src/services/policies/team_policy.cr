class TeamPolicy < BasePolicy
  def self.show?(team : Team, current_user : User | Nil, context)
    forbidden(context) do
      true
    end
  end

  def self.list_private_repos?(team : Team, current_user : User | Nil, context) : Bool
    team.users!.map(&.id).includes?(current_user.not_nil!.id)
  end

  def self.update?(team : Team, current_user : User | Nil, context)
    forbidden(context) do
      return false if current_user.nil?
      team.users!.map(&.id).includes?(current_user.not_nil!.id)
    end
  end

  def self.invite?(team : Team, current_user : User | Nil, context)
    forbidden(context) do
      return false if current_user.nil?
      team.users!.map(&.id).includes?(current_user.not_nil!.id)
    end
  end
end
