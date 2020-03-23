class Repositories::Issues::IndexPage < ShowLayout
  needs issues : IssueQuery
  needs current_user : User | Nil
  needs repository : Repository
  needs namespace : Namespace
  quick_def page_title, "Issues"
  quick_def single_page, "Issues"

  def content
    render_template "repositories/repo_info_small.html.ecr"
    render_template "repositories/repo_links.html.ecr"
    render_template "issues/index.html.ecr"
  end
end
