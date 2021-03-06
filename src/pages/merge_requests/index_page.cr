class Repositories::MergeRequests::IndexPage < ShowLayout
  needs merge_requests : MergeRequestQuery
  needs repository : Repository
  needs namespace : Namespace
  needs current_user : User | Nil
  quick_def page_title, "Merge Requests"
  quick_def single_page, "Merge Requests"

  def content
    render_template "repositories/repo_info_small.html.ecr"
    render_template "repositories/repo_links.html.ecr"
    render_template "merge_requests/index.html.ecr"
  end
end
