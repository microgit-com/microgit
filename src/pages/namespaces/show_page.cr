class Namespaces::ShowPage < MainLayout
  needs namespace : Namespace
  quick_def page_title, @namespace.slug

  def content
    link "Back to all Namespaces", Namespaces::Index
    h1 @namespace.slug
    render_actions
    render_namespace_fields
  end

  def render_actions
    section do
      link "Edit", Namespaces::Edit.with(@namespace.id)
      text " | "
      link "Delete",
        Namespaces::Delete.with(@namespace.id),
        data_confirm: "Are you sure?"
    end
  end

  def render_namespace_fields
    ul do
      li do
        text "slug: "
        strong @namespace.slug.to_s
      end
    end
  end
end
