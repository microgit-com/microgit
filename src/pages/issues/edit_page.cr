class Repositories::Issues::EditPage < MainLayout
  needs operation : SaveIssue
  needs issue : Issue
  needs repository : Repository
  quick_def page_title, "Edit"

  def content
    h1 "Edit"
    render_issue_form(@operation)
  end

  def render_issue_form(op)
    form_for Issues::Update.with(@repository.id, @issue.id) do
      mount Shared::Field.new(op.name), &.text_input(autofocus: "true", append_class: "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline my-2")
      mount Shared::Field.new(op.description), &.text_input(autofocus: "true", append_class: "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline my-2")

      submit "Update", data_disable_with: "Updating...", class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
    end
  end
end
