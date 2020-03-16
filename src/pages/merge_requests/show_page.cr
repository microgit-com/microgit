class Repositories::MergeRequests::ShowPage < MainLayout
  needs merge_request : MergeRequest
  needs repository : Repository
  needs namespace : Namespace
  needs comments : ActivityForItemsQuery
  needs operation : SaveActivityForItems
  needs diff : Git::Diff
  needs ahead : Int32
  needs behind : Int32
  quick_def page_title, @merge_request.name.to_s
  quick_def single_page, @merge_request.name.to_s
  quick_def page_title_template, render_template("merge_requests/info_header.html.ecr")

  def content
    render_template "repositories/repo_info_small.html.ecr"
    render_template "repositories/repo_links.html.ecr"
    render_template "merge_requests/show.html.ecr"
    render_comment_form(@operation)
  end

  def render_comment_form(op)
    form_for MergeRequests::Activities::Create.with(@namespace.slug, @repository.slug, @merge_request.id) do
      textarea(op.text, rows: "10", cols: "20", class: "form-textarea mt-1 block w-full shadow appearance-none")
      submit "Save", data_disable_with: "Saving...", class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 mt-4 mb-4 rounded focus:outline-none focus:shadow-outline"
    end
  end
end
