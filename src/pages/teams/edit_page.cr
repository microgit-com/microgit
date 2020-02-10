class Teams::EditPage < MainLayout
  needs operation : SaveTeam
  needs team : Team
  quick_def page_title, "Edit"

  def content
    h1 "Edit"
    render_team_form(@operation)
  end

  def render_team_form(op)
    form_for Teams::Update.with(@team.id) do
      mount Shared::Field.new(op.name)
      mount Shared::Field.new(op.description)

      submit "Update", data_disable_with: "Updating..."
    end
  end
end
