class Repositories::ShowPage < MainLayout
  needs repository : Repository
  quick_def page_title, @repository.name

  def content
    link "Back to all Repositories", Repositories::Index
    h1 @repository.name
    render_actions
    render_repository_fields
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

  def render_repository_fields
    ul do
      li do
        text "name: "
        strong @repository.name.to_s
      end
      li do
        text "description: "
        strong @repository.description.to_s
      end
      li do
        text "slug: "
        strong @repository.slug.to_s
      end
      li do
        text "privated: "
        strong @repository.privated.to_s
      end
      li do
        text "user: "
        strong @repository.user.email.to_s
      end
    end
  end
end
