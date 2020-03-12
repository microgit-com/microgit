class Repositories::MergeRequests::ChangesPage < MainLayout
  needs merge_request : MergeRequest
  needs repository : Repository
  needs namespace : Namespace
  needs diff : Git::Diff
  quick_def page_title, @merge_request.name
  include DiffHelper

  def content
    render_template "repositories/repo_info_small.html.ecr"
    render_template "repositories/repo_links.html.ecr"
    render_template "merge_requests/changes.html.ecr"
  end
end
