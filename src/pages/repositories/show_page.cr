class Repositories::ShowPage < ShowLayout
  needs repository : Repository
  needs repo : MicrogitGit
  needs readme : Git::TreeEntry | Nil
  needs readme_content : String | Nil
  needs current_user : User | Nil
  needs namespace_slug : String | Nil
  needs tree : Git::Tree | Nil
  needs branch_name : String
  quick_def page_title, @repository.name
  quick_def page_title_template, render_template("repositories/repo_info.html.ecr")

  def content
    render_template "repositories/repo_links.html.ecr"
    render_template "repositories/repo_dashboard.html.ecr"
  end
end
