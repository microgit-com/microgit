class Repositories::MergeRequests::IndexPage < MainLayout
  needs merge_requests : MergeRequestQuery
  needs repository : Repository
  needs namespace : Namespace
  quick_def page_title, "All"

  def content
    render_template "repositories/repo_links.html.ecr"
    render_template "merge_requests/index.html.ecr"
  end
end
