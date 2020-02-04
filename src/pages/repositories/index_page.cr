class Repositories::IndexPage < MainLayout
  needs repositories : RepositoryQuery
  quick_def page_title, "All"

  def content
    h1 "All Repositories"
    link "New Repository", to: Repositories::New
    render_repositories
  end

  def render_repositories
    ul do
      @repositories.each do |repository|
        li do
          link repository.name, Repositories::Show.with(repository)
        end
      end
    end
  end
end
