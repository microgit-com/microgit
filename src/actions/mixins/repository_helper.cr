module RepositoryHelper
  def check_access
    namespace = get_namespace
    if namespace.item.is_a?(User)
      repository = RepositoryQuery.new.preload_user.preload_team.user_id(namespace.item.id).slug(repository_slug).first
    else
      repository = RepositoryQuery.new.preload_team.preload_user.team_id(namespace.item.id).slug(repository_slug).first
    end
    RepositoryPolicy.show?(repository, current_user, context)
    repository
  end

  def check_simple_access_slug
    repository = RepositoryQuery.new.preload_team.preload_user.slug(repository_slug).first
    RepositoryPolicy.show?(repository, current_user, context)
    repository
  end

  def get_namespace
    NamespaceQuery.new.preload_user.preload_team.slug(namespace_slug).first
  end
end
