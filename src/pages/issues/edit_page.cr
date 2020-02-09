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
      mount Shared::Field.new(op.name), &.text_input(autofocus: "true")
      mount Shared::Field.new(op.description)

      submit "Update", data_disable_with: "Updating..."
    end
  end
end
