class Repositories::Issues::Show < RepositoryAction
  include Auth::AllowGuests

  get "/:namespace_slug/:repository_slug/issues/:issue_id" do
    issue = IssueQuery.new.preload_author.preload_assignee.repository_id(@repository.not_nil!.id).find_scoped(issue_id.to_i64)
    comments = ActivityForItemsQuery.new.preload_user.issue_id(issue.id)
    html ShowPage, operation: SaveActivityForItems.new, issue: issue, repository: @repository.not_nil!, namespace: @namespace.not_nil!, comments: comments
  end
end
