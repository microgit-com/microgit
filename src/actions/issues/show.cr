class Repositories::Issues::Show < BrowserAction
  include RepositoryHelper

  get "/:namespace_slug/:repository_slug/issues/:issue_id" do
    issue = IssueQuery.new.preload_author.preload_assignee.find(issue_id)
    repository = check_access
    namespace = get_namespace
    comments = ActivityForItemsQuery.new.preload_user.issue_id(issue_id)
    html ShowPage, operation: SaveActivityForItems.new, issue: issue, repository: repository, namespace: namespace, comments: comments
  end
end
