class Repositories::Show < BrowserAction
  route do
    repository = RepositoryQuery.new.preload_user.find(repository_id)
    repo = MicrogitGit.new(repository)
    readme = nil
    readme_content = nil
    unless repo.raw.empty?
      readme = repo.find_file("README.md")
      readme_content = repo.find_file_blob("README.md")
      unless readme_content.nil?
        readme_content = Markd.to_html(readme_content.try { |r| r.content })
      end
    end
    html ShowPage, repository: repository, repo: repo, readme: readme, readme_content: readme_content
  end
end
