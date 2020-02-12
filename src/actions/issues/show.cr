class Repositories::Issues::Show < BrowserAction
  get "/:namespace_slug/:repository_slug/issues/:issue_id" do
    issue = IssueQuery.new.preload_author.preload_assignee.find(issue_id)
    repository = RepositoryQuery.new.preload_team.preload_user.find(issue.repository_id)
    RepositoryPolicy.show?(repository, current_user, context)
    html ShowPage, issue: issue, repository: repository
  end
end
