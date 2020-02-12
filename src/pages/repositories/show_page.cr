class Repositories::ShowPage < ShowLayout
  needs repository : Repository
  needs repo : MicrogitGit
  needs readme : Git::TreeEntry | Nil
  needs readme_content : String | Nil
  needs current_user : User | Nil
  quick_def page_title, @repository.name

  def content
    render_template "repositories/repo_info.html.ecr"
    render_template "repositories/repo_links.html.ecr"
    render_template "repositories/repo_dashboard.html.ecr"
  end
end
