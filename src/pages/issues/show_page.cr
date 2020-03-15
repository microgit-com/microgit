class Repositories::Issues::ShowPage < MainLayout
  needs issue : Issue
  needs repository : Repository
  needs namespace : Namespace
  needs comments : ActivityForItemsQuery
  needs operation : SaveActivityForItems
  quick_def single_page, @issue.name.to_s
  quick_def page_title, @issue.name.to_s

  def content
    render_template "repositories/repo_info_small.html.ecr"
    render_template "repositories/repo_links.html.ecr"
    render_template "issues/show.html.ecr"
    render_comment_form(@operation)
  end

  def render_comment_form(op)
    form_for Issues::Activities::Create.with(@namespace.slug, @repository.slug, @issue.id) do
      textarea(op.text, rows: "10", cols: "20", class: "form-textarea mt-1 block w-full shadow appearance-none")
      submit "Save", data_disable_with: "Saving...", class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 mt-4 rounded focus:outline-none focus:shadow-outline"
    end
  end
end
