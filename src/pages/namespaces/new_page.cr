class Namespaces::NewPage < MainLayout
  needs operation : SaveNamespace
  quick_def page_title, "New"

  def content
    h1 "New"
    render_namespace_form(@operation)
  end

  def render_namespace_form(op)
    form_for Namespaces::Create do
      mount Shared::Field.new(op.slug), &.text_input(autofocus: "true")

      submit "Save", data_disable_with: "Saving..."
    end
  end
end
