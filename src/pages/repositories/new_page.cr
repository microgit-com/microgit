class Repositories::NewPage < MainLayout
  needs operation : SaveRepository
  quick_def page_title, "New"

  def content
    h1 "New"
    render_repository_form(@operation)
  end

  def render_repository_form(op)
    form_for Repositories::Create do
      mount Shared::Field.new(op.name), &.text_input(autofocus: "true")
      mount Shared::Field.new(op.description)
      mount Shared::Field.new(op.slug)
      mount Shared::Field.new(op.privated)

      submit "Save", data_disable_with: "Saving..."
    end
  end
end
