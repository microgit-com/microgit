class Namespaces::Show < BrowserAction
  include Auth::AllowGuests
  include RepositoryHelper

  get "/:namespace_slug" do
    namespace = get_namespace
    item = namespace.item
    if item.is_a?(User)
      html ShowUserPage, user: item, repositories: RepositoryQuery.new.preload_user.preload_team.user_id(item.id)
    elsif item.is_a?(Team)
      html ShowTeamPage, team: item, repositories: RepositoryQuery.new.preload_user.preload_team.team_id(item.id)
    else
      raise Lucky::RouteNotFoundError.new(context)
    end
  end
end
