class Repositories::ShowPage < MainLayout
  needs repository : Repository
  quick_def page_title, @repository.name

  def content
    render_template "repositories/repo_info.html.ecr"
    render_template "repositories/repo_dashboard.html.ecr"
    render_actions
  end

  def render_actions
    section do
      link "Edit", Repositories::Edit.with(@repository.id)
      text " | "
      link "Delete",
        Repositories::Delete.with(@repository.id),
        data_confirm: "Are you sure?"
    end
  end
end
