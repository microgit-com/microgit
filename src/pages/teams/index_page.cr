class Teams::IndexPage < MainLayout
  needs teams : TeamQuery
  quick_def page_title, "All"

  def content
    render_template "teams/index.html.ecr"
  end
end
