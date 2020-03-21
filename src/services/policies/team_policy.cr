class TeamPolicy
  def self.show?(team : Team, current_user : User | Nil, context)
    raiser(context) do
      true
    end
  end

  def self.update?(team : Team, current_user : User | Nil, context)
    raiser(context) do
      return false if current_user.nil?
      team.users!.map(&.id).includes?(current_user.not_nil!.id)
    end
  end

  def self.invite?(team : Team, current_user : User | Nil, context)
    raiser(context) do
      return false if current_user.nil?
      team.users!.map(&.id).includes?(current_user.not_nil!.id)
    end
  end

  private def self.raiser(context, &block)
    unless yield
      raise LuckyForbiddenError.new(context)
    end
  end
end
