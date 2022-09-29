class Teams::EditPage < MainLayout
  needs operation : UpdateTeam
  needs team : Team
  quick_def page_title, "Edit"

  def content
    h1 "Edit"
    render_team_form(@operation)
  end

  def render_team_form(op)
    form_for Teams::Update.with(@team.id) do
      mount Shared::Field, attribute: op.name
      mount Shared::Field, attribute: op.description

      submit "Update", data_disable_with: "Updating..."
    end
  end
end
