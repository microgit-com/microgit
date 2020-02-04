class Repositories::EditPage < MainLayout
  needs operation : SaveRepository
  needs repository : Repository
  quick_def page_title, "Edit"

  def content
    h1 "Edit"
    render_repository_form(@operation)
  end

  def render_repository_form(op)
    form_for Repositories::Update.with(@repository.id) do
      mount Shared::Field.new(op.name), &.text_input(autofocus: "true")
      mount Shared::Field.new(op.description)
      mount Shared::Field.new(op.slug)
      mount Shared::Field.new(op.privated)

      submit "Update", data_disable_with: "Updating..."
    end
  end
end
