module RepositoryHelper
  @repository : Repository?
  def check_access
    repository = get_repository
    RepositoryPolicy.show_not_found?(repository, current_user, context)
    repository
  end

  def check_simple_access_slug
    repository = RepositoryQuery.new.preload_team.preload_user.slug(repository_slug).first
    RepositoryPolicy.show_not_found?(repository, current_user, context)
    repository
  end

  def get_repository : Repository
    return @repository.not_nil! unless @repository.nil?
    namespace = get_namespace
    if namespace.item.is_a?(User)
      @repository = RepositoryQuery.new.preload_user.preload_team.user_id(namespace.item.id).slug(repository_slug).first
    else
      @repository = RepositoryQuery.new.preload_team.preload_user.team_id(namespace.item.id).slug(repository_slug).first
    end
    return @repository.not_nil!
  end

  def get_namespace
    NamespaceQuery.new.preload_user.preload_team.slug(namespace_slug).first
  end
end
