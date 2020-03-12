class Repositories::Branches::IndexPage < MainLayout
  needs repo : MicrogitGit
  needs repository : Repository
  needs namespace : Namespace
  needs branches : Array(String)
  quick_def page_title, "All"

  def content
    render_template "repositories/repo_info_small.html.ecr"
    render_template "repositories/repo_links.html.ecr"
    render_template "branches/index.html.ecr"
  end
end
