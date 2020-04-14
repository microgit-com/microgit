class Repositories::Show < RepositoryAction
  include Auth::AllowGuests

  get "/:namespace_slug/:repository_slug" do
    begin
      repo = MicrogitGit.new(@repository.not_nil!)
    rescue Exception
      raise Lucky::RouteNotFoundError.new(context)
    end
    readme = nil
    readme_content = nil
    unless repo.raw.empty?
      readme = repo.find_file("README.md")
      readme_content = repo.find_file_blob("README.md")
      unless readme_content.nil?
        readme_content = Markd.to_html(readme_content.try { |r| r.content })
      end
    end
    html ShowPage, repository: @repository.not_nil!, repo: repo, tree: repo.tree, branch_name: "master", readme: readme, readme_content: readme_content, namespace_slug: namespace_slug
  end
end
