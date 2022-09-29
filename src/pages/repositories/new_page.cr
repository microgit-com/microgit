class Repositories::NewPage < MainLayout
  needs operation : SaveRepository
  quick_def page_title, "New"

  def content
    h1 "New"
    render_repository_form(@operation)
  end

  def render_repository_form(op)
    form_for Repositories::Create do
      mount Shared::Field, attribute: op.name, &.text_input(autofocus: "true", append_class: "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline my-2")
      mount Shared::Field, attribute: op.description, &.textarea(append_class: "form-textarea mt-1 block w-full shadow appearance-none")
      mount Shared::Field, attribute: op.privated, &.checkbox(append_class: "form-checkbox block clear-both my-2")

      submit "Save", data_disable_with: "Saving...", class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
    end
  end
end
