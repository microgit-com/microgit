class Repositories::Branches::ShowPage < ShowLayout
  needs repository : Repository
  needs repo : MicrogitGit
  needs branch_name : String
  needs tree : Git::Tree | Nil
  needs current_user : User | Nil
  include DiffHelper
  quick_def single_page, @branch_name
  quick_def page_title, @branch_name

  def content
    render_template "repositories/repo_info_small.html.ecr"
    render_template "repositories/repo_links.html.ecr"
    render_template "branches/show.html.ecr"
  end
end
