class Repositories::MergeRequests::ChangesPage < MainLayout
  needs merge_request : MergeRequest
  needs repository : Repository
  needs namespace : Namespace
  quick_def page_title, @merge_request.name

  def content
    render_template "repositories/repo_links.html.ecr"
    render_template "merge_requests/changes.html.ecr"
  end
end
