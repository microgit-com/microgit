class BasePolicy
  def self.forbidden(context, &block)
    unless yield
      raise LuckyForbiddenError.new(context)
    end
  end

  def self.not_found(context, &block)
    unless yield
      raise Lucky::RouteNotFoundError.new(context)
    end
  end
end
