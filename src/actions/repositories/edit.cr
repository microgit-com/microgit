class Repositories::Edit < BrowserAction
  get "/:namespace_slug/:repository_slug/edit" do
    namespace = NamespaceQuery.new.preload_user.preload_team.slug(namespace_slug).first
    if namespace.item.is_a?(User)
      repository = RepositoryQuery.new.preload_user.preload_team.user_id(namespace.item.id).slug(repository_slug).first
    else
      repository = RepositoryQuery.new.preload_team.preload_user.team_id(namespace.item.id).slug(repository_slug).first
    end
    begin
      answer = RepositoryPolicy.show?(repository, current_user)
      unless answer
        raise Lucky::RouteNotFoundError.new(context)
      end
    rescue ex : Exception
      raise Lucky::RouteNotFoundError.new(context)
    end
    html EditPage,
      operation: SaveRepository.new(repository),
      repository: repository
  end
end
