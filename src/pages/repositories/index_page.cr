class Repositories::IndexPage < MainLayout
  needs repositories : RepositoryQuery
  quick_def page_title, "All"

  def content
    render_template "repositories/index.html.ecr"
  end
end
