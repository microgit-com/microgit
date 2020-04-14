abstract class RepositoryAction < BrowserAction
  include RepositoryHelper

  before require_namespace
  before require_repository

  def require_namespace
    if get_namespace.nil?
      raise Lucky::RouteNotFoundError.new(context)
    else
      @namespace = get_namespace.not_nil!
      continue
    end
  end

  def require_repository
    if RepositoryPolicy.show?(get_repository, current_user)
      @repository = get_repository.not_nil!
      continue
    else
      raise Lucky::RouteNotFoundError.new(context)
    end
  end
end
