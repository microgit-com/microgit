class Repositories::Show < BrowserAction
  include Auth::AllowGuests
  
  get "/:namespace_slug/:repository_slug" do
    namespace = NamespaceQuery.new.preload_user.preload_team.slug(namespace_slug).first
    if namespace.item.is_a?(User)
      repository = RepositoryQuery.new.preload_user.preload_team.user_id(namespace.item.id).slug(repository_slug).first
    else
      repository = RepositoryQuery.new.preload_team.preload_user.team_id(namespace.item.id).slug(repository_slug).first
    end
    begin
      answer = RepositoryPolicy.show?(repository, current_user)
      unless answer
        raise Lucky::RouteNotFoundError.new(context)
      end
    rescue ex : Exception
      raise Lucky::RouteNotFoundError.new(context)
    end
    begin
      repo = MicrogitGit.new(repository)
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
    html ShowPage, repository: repository, repo: repo, readme: readme, readme_content: readme_content
  end
end
