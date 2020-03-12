class Repositories::EditPage < MainLayout
  needs operation : SaveRepository
  needs repository : Repository
  quick_def page_title, "Edit"

  def content
    render_template "repositories/repo_info_small.html.ecr"
    h1 "Edit"
    render_repository_form(@operation)
  end

  def render_repository_form(op)
    form_for Repositories::Update.with(@repository.id) do
      mount Shared::Field.new(op.name), &.text_input(autofocus: "true", append_class: "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline my-2")
      mount Shared::Field.new(op.description), &.textarea(append_class: "form-textarea mt-1 block w-full shadow appearance-none")
      mount Shared::Field.new(op.privated), &.checkbox(append_class: "form-checkbox block clear-both my-2")

      submit "Update", data_disable_with: "Updating...", class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 mt-4 rounded focus:outline-none focus:shadow-outline"
    end
  end
end
