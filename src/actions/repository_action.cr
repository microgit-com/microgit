abstract class RepositoryAction < BrowserAction
  include RepositoryHelper

  before require_repository

  def require_repository
    if RepositoryPolicy.show?(get_repository, current_user)
      continue
    else
      raise Lucky::RouteNotFoundError.new(context)
    end
  end
end
