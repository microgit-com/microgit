class BasePolicy
  def self.forbidden(context, &block)
    unless yield
      raise LuckyForbiddenError.new(context)
      return false
    end
    true
  end

  def self.not_found(context, &block)
    unless yield
      raise Lucky::RouteNotFoundError.new(context)
      return false
    end
    true
  end

  macro can(name, *methods)
    def self.{{name}}?({% for method in methods %}{{method.id}},{% end %}) : Bool
      {{yield}}
    rescue Avram::RecordNotFoundError
      false
    end

    def self.{{name}}_forbidden?({% for method in methods %}{{method.id}},{% end %} context) : Bool
      forbidden(context) do
        {{name}}?({% for method in methods %}{{method.id}},{% end %})
      end
    end

    def self.{{name}}_not_found?({% for method in methods %}{{method.id}},{% end %} context) : Bool
      not_found(context) do
        {{name}}?({% for method in methods %}{{method.id}},{% end %})
      end
    end
  end
end
