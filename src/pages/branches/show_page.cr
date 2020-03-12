class Repositories::Branches::ShowPage < MainLayout
  needs repository : Repository
  needs repo : MicrogitGit
  needs branch_name : String
  needs tree : Git::Tree | Nil
  include DiffHelper

  def content
    render_template "repositories/repo_links.html.ecr"
    render_template "branches/show.html.ecr"
  end
end