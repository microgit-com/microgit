class Repositories::Issues::NewPage < MainLayout
  needs operation : SaveIssue
  needs repository : Repository
  quick_def page_title, "New"

  def content
    h1 "New"
    render_issue_form(@operation)
  end

  def render_issue_form(op)
    form_for Issues::Create.with(@repository) do
      mount Shared::Field.new(op.name), &.text_input(autofocus: "true", append_class: "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline my-2")
      mount Shared::Field.new(op.description), &.textarea(append_class: "form-textarea mt-1 block w-full shadow appearance-none")

      submit "Save", data_disable_with: "Saving...", class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 mt-4 rounded focus:outline-none focus:shadow-outline"
    end
  end
end
