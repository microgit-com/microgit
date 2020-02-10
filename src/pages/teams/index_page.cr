class Teams::IndexPage < MainLayout
  needs teams : TeamQuery
  quick_def page_title, "All"

  def content
    h1 "All Teams"
    link "New Team", to: Teams::New
    render_teams
  end

  def render_teams
    ul do
      @teams.each do |team|
        li do
          link team.name, Teams::Show.with(team)
        end
      end
    end
  end
end
