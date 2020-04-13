class Repositories::Issues::Edit < RepositoryAction

  get "/:namespace_slug/:repository_slug/issues/:issue_id/edit" do
    issue = IssueQuery.find(issue_id)
    repository = get_repository
    html EditPage,
      operation: SaveIssue.new(issue),
      issue: issue,
      repository: repository
  end
end
