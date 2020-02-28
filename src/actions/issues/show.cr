class Repositories::Issues::Show < BrowserAction
  include RepositoryHelper

  get "/:namespace_slug/:repository_slug/issues/:issue_id" do
    issue = IssueQuery.new.preload_author.preload_assignee.find(issue_id)
    repository = check_access
    html ShowPage, issue: issue, repository: repository
  end
end
