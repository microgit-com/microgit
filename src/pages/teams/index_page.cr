class Teams::IndexPage < MainLayout
  needs teams : TeamQuery
  quick_def page_title, "Teams"

  def content
    render_template "teams/index.html.ecr"
  end
end
