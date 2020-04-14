class Repositories::Issues::Show < RepositoryAction
  include Auth::AllowGuests

  get "/:namespace_slug/:repository_slug/issues/:issue_id" do
    issue = IssueQuery.new.preload_author.preload_assignee.find(issue_id)
    comments = ActivityForItemsQuery.new.preload_user.issue_id(issue_id)
    html ShowPage, operation: SaveActivityForItems.new, issue: issue, repository: @repository.not_nil!, namespace: @namespace.not_nil!, comments: comments
  end
end
