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
      mount Shared::Field.new(op.name), &.text_input(autofocus: "true")
      mount Shared::Field.new(op.description)

      submit "Save", data_disable_with: "Saving..."
    end
  end
end
