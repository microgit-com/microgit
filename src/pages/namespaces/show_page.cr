class Namespaces::ShowPage < MainLayout
  needs namespace : Namespace
  quick_def page_title, @namespace.slug

  def content
    h1 "namespace"
  end
end
