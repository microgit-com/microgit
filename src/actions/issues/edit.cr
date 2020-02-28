class Repositories::Issues::Edit < BrowserAction
  include ::RepositoryHelper

  get "/:namespace_slug/:repository_slug/issues/:issue_id/edit" do
    issue = IssueQuery.find(issue_id)
    repository = check_access
    html EditPage,
      operation: SaveIssue.new(issue),
      issue: issue,
      repository: repository
  end
end
