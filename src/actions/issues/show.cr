class Repositories::Issues::Show < BrowserAction
  get "/:user_slug/:repository_slug/issues/:issue_id" do
    issue = IssueQuery.new.preload_repository.preload_author.preload_assignee.find(issue_id)
    html ShowPage, issue: issue, repository: issue.repository
  end
end
