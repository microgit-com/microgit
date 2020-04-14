module RepositoryHelper
  @repository : Repository?
  @namespace : Namespace?
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

  def get_repository : Repository | Nil
    return @repository unless @repository.nil?
    namespace = get_namespace
    return nil if namespace.nil?
    if namespace.item.is_a?(User)
      @repository = RepositoryQuery.new.preload_user.preload_team.user_id(namespace.not_nil!.item.id).slug(repository_slug).first
    elsif namespace.item.is_a?(Team)
      @repository = RepositoryQuery.new.preload_team.preload_user.team_id(namespace.not_nil!.item.id).slug(repository_slug).first
    end
    return @repository
  rescue Avram::RecordNotFoundError
    return nil
  end

  def get_namespace : Namespace | Nil
    return @namespace unless @namespace.nil?
    @namespace = NamespaceQuery.new.preload_user.preload_team.slug(namespace_slug).first
    return @namespace
  rescue Avram::RecordNotFoundError
    return nil
  end
end
