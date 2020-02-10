class Repositories::Issues::Index < BrowserAction
  get "/:user_slug/:repository_slug/issues" do
    repository = RepositoryQuery.new.preload_user.slug(repository_slug).first
    html IndexPage, issues: IssueQuery.new.preload_author, repository: repository
  end
end
