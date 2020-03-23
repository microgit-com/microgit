class Repositories::Branches::IndexPage < ShowLayout
  needs repo : MicrogitGit
  needs repository : Repository
  needs namespace : Namespace
  needs current_user : User | Nil
  needs branches : Array(String)
  quick_def page_title, "Branches"
  quick_def single_page, "Branches"

  def content
    render_template "repositories/repo_info_small.html.ecr"
    render_template "repositories/repo_links.html.ecr"
    render_template "branches/index.html.ecr"
  end
end
