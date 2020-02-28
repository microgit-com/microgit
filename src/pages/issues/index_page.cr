class Repositories::Issues::IndexPage < MainLayout
  needs issues : IssueQuery
  needs repository : Repository
  quick_def page_title, "All"

  def content
    render_template "repositories/repo_links.html.ecr"
    render_template "issues/index.html.ecr"
  end
end
