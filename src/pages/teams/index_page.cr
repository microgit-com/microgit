class Teams::IndexPage < MainLayout
  needs teams : Array(Team)
  quick_def page_title, "Teams"

  def content
    render_template "teams/index.html.ecr"
  end
end
