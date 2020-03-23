class UserPolicy < BasePolicy
  def self.show?(user : User, current_user : User | Nil, context)
    forbidden(context) do
      true
    end
  end

  def self.list_private_repos?(user : User, current_user : User | Nil, context) : Bool
    return false if current_user.nil?
    user.id == current_user.id
  end

  def self.update?(user : User, current_user : User | Nil, context)
    forbidden(context) do
      return false if current_user.nil?
      user.id == current_user.id
    end
  end

  def self.invite?(user : User, current_user : User | Nil, context)
    forbidden(context) do
      return false if current_user.nil?
      user.id == current_user.id
    end
  end
end
