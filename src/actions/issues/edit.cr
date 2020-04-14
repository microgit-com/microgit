class Repositories::Issues::Edit < RepositoryAction
  get "/:namespace_slug/:repository_slug/issues/:issue_id/edit" do
    issue = IssueQuery.find(issue_id)

    IssuePolicy.update_forbidden?(issue, current_user, context)

    html EditPage,
      operation: SaveIssue.new(issue),
      issue: issue,
      repository: @repository.not_nil!
  end
end
