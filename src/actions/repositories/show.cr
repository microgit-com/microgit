class Repositories::Show < BrowserAction
  route do
    repository = RepositoryQuery.new.preload_user.find(repository_id)
    repo = MicrogitGit.new(repository)
    readme = repo.find_file("README.md")
    readme_content = repo.find_file_blob("README.md")
    html ShowPage, repository: repository, repo: repo, readme: readme, readme_content: readme_content
  end
end
