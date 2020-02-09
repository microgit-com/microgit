class Repositories::Issues::ShowPage < MainLayout
  needs issue : Issue
  needs repository : Repository

  def content
    render_template "repositories/repo_links.html.ecr"
    render_template "issues/show.html.ecr"
  end
end
