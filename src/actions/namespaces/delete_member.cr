class Namespaces::DeleteMember < BrowserAction
  include RepositoryHelper

  delete "/:namespace_slug/members/:id" do
    namespace = get_namespace
    raise Lucky::RouteNotFoundError.new(context) if namespace.nil?
    item = namespace.not_nil!.item
    raise Lucky::RouteNotFoundError.new(context) unless item.is_a?(Team)

    member = TeamMembersQuery.new.team_id(item.id).id(id).first

    member.delete
    flash.success = "Deleted the record"
    redirect Namespaces::Members.with(namespace.slug)

  end
end
