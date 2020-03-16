class Repositories::MergeRequests::ChangesPage < MainLayout
  needs merge_request : MergeRequest
  needs repository : Repository
  needs namespace : Namespace
  needs diff : Git::Diff
  needs behind : Int32
  needs ahead : Int32
  quick_def page_title, "Merge Requests Changes"
  quick_def single_page, "Merge Requests Changes"
  include DiffHelper

  def content
    render_template "repositories/repo_info_small.html.ecr"
    render_template "repositories/repo_links.html.ecr"
    render_template "merge_requests/changes.html.ecr"
  end
end
