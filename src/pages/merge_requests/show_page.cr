class Repositories::MergeRequests::ShowPage < MainLayout
  needs merge_request : MergeRequest
  needs repository : Repository
  quick_def page_title, @merge_request.name

  def content
    h1 @merge_request.name.to_s
  end
end
