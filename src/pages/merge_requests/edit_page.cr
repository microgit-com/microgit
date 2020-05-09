class Repositories::MergeRequests::EditPage < MainLayout
  needs operation : SaveMergeRequest
  needs merge_request : MergeRequest
  needs repository : Repository
  quick_def page_title, "Edit"
  quick_def single_page, "Merge Request Edit"

  def content
    render_template "repositories/repo_info_small.html.ecr"
    h1 "Edit"
    render_merge_request_form(@operation)
  end

  def render_merge_request_form(op)
    form_for MergeRequests::Update.with(@repository.namespace_slug, @repository.slug, @merge_request.id) do
      mount Shared::Field.new(op.name), &.text_input(autofocus: "true")
      mount Shared::Field.new(op.description), &.textarea(append_class: "form-textarea mt-1 block w-full shadow appearance-none", id: "simple_editor")

      submit "Update", data_disable_with: "Updating..."
    end
  end
end
