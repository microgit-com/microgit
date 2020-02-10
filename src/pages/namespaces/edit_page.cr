class Namespaces::EditPage < MainLayout
  needs operation : SaveNamespace
  needs namespace : Namespace
  quick_def page_title, "Edit"

  def content
    h1 "Edit"
    render_namespace_form(@operation)
  end

  def render_namespace_form(op)
    form_for Namespaces::Update.with(@namespace.id) do
      mount Shared::Field.new(op.slug), &.text_input(autofocus: "true")

      submit "Update", data_disable_with: "Updating..."
    end
  end
end
