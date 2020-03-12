class Repositories::Issues::IndexPage < MainLayout
  needs issues : IssueQuery
  needs repository : Repository
  needs namespace : Namespace
  quick_def page_title, "All"
  quick_def single_page, "Issues"

  def content
    render_template "repositories/repo_info_small.html.ecr"
    render_template "repositories/repo_links.html.ecr"
    render_template "issues/index.html.ecr"
  end
end
