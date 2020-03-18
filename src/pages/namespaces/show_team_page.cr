class Namespaces::ShowTeamPage < MainLayout
  needs team : Team
  needs repositories : RepositoryQuery
  quick_def page_title, @team.name
  quick_def page_title_template, render_template("namespaces/show_team_info.html.ecr")

  def content
    render_template "teams/repositories.html.ecr"
  end
end
