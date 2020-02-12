class Teams::ShowPage < MainLayout
  needs team : Team
  quick_def page_title, @team.name

  def content
    link "Back to all Teams", Teams::Index
    h1 @team.name
    render_actions
    render_team_fields
  end

  def render_actions
    section do
      link "Edit", Teams::Edit.with(@team.id)
      text " | "
      link "Delete",
        Teams::Delete.with(@team.id),
        data_confirm: "Are you sure?"
    end
  end

  def render_team_fields
    ul do
      li do
        text "name: "
        strong @team.name.to_s
      end
      li do
        text "slug: "
        strong @team.namespace.slug.to_s
      end
      li do
        text "description: "
        strong @team.description.to_s
      end
    end
  end
end
