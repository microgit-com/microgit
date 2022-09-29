class Teams::NewPage < MainLayout
  needs operation : CreateTeam
  quick_def page_title, "New"

  def content
    h1 "New"
    render_team_form(@operation)
  end

  def render_team_form(op)
    form_for Teams::Create do
      mount Shared::Field, attribute: op.name
      mount Shared::Field, attribute: op.description

      submit "Save", data_disable_with: "Saving..."
    end
  end
end
