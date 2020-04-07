class Namespaces::Members < BrowserAction
  include RepositoryHelper

  get "/:namespace_slug/members" do
    namespace = get_namespace
    item = namespace.item
    raise Lucky::RouteNotFoundError.new(context) unless item.is_a?(Team)

    TeamPolicy.see_members_forbidden?(item, current_user, context)

    html MembersPage, team: item, members: item.team_members!
  end
end
