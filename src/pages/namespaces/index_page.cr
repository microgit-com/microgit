class Namespaces::IndexPage < MainLayout
  needs namespaces : NamespaceQuery
  quick_def page_title, "All"

  def content
    h1 "All Namespaces"
    link "New Namespace", to: Namespaces::New
    render_namespaces
  end

  def render_namespaces
    ul do
      @namespaces.each do |namespace|
        li do
          link namespace.slug, Namespaces::Show.with(namespace)
        end
      end
    end
  end
end
