class Repositories::Issues::Index < BrowserAction
  get "/:namespace_slug/:repository_slug/issues" do
    namespace = NamespaceQuery.new.preload_user.preload_team.slug(namespace_slug).first
    if namespace.item.is_a?(User)
      repository = RepositoryQuery.new.preload_user.preload_team.user_id(namespace.item.id).slug(repository_slug).first
    else
      repository = RepositoryQuery.new.preload_team.preload_user.team_id(namespace.item.id).slug(repository_slug).first
    end
    RepositoryPolicy.show?(repository, current_user, context)
    html IndexPage, issues: IssueQuery.new.preload_author, repository: repository
  end
end
