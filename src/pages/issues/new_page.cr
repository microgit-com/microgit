class Repositories::Issues::NewPage < MainLayout
  needs operation : CreateIssue
  needs repository : Repository
  quick_def page_title, "New"
  quick_def single_page, "New Issue"

  def content
    render_template "repositories/repo_info_small.html.ecr"
    h1 "New"
    render_issue_form(@operation)
  end

  def render_issue_form(op)
    form_for Issues::Create.with(@repository.namespace_slug, @repository.slug) do
      mount Shared::Field, attribute: op.name, &.text_input(autofocus: "true", append_class: "shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline my-2")
      mount Shared::Field, attribute: op.description, &.textarea(append_class: "form-textarea mt-1 block w-full shadow appearance-none", id: "simple_editor")

      submit "Save", data_disable_with: "Saving...", class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 mt-4 rounded focus:outline-none focus:shadow-outline"
    end
  end
end
