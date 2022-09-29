class Repositories::MergeRequests::NewPage < MainLayout
  needs operation : CreateMergeRequest
  needs repository : Repository
  needs namespace : Namespace
  quick_def page_title, "New"
  quick_def single_page, "New Merge Request"

  def content
    render_template "repositories/repo_info_small.html.ecr"
    h1 "New"
    render_merge_request_form(@operation)
  end

  def render_merge_request_form(op)
    form_for MergeRequests::Create.with(@namespace.slug, @repository.slug) do
      mount Shared::Field, attribute: op.name
      mount Shared::Field, attribute: op.description, &.textarea(append_class: "form-textarea mt-1 block w-full shadow appearance-none", id: "simple_editor")
      label_for(op.branch)
      select_input(op.branch, class: "shadow block appearance-none w-full bg-gray-200 border border-gray-200 text-gray-700 py-3 px-4 pr-8 rounded leading-tight focus:outline-none focus:bg-white focus:border-gray-500") do
        options_for_select(op.branch, options_for_branches)
      end

      submit "Save", data_disable_with: "Saving...", class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 mt-4 rounded focus:outline-none focus:shadow-outline"
    end
  end

  private def options_for_branches : Array(Tuple(String, String))
    branch_names = [] of {String, String}

    repo = MicrogitGit.new(@repository)
    branches = repo.raw.branches
    branches.each_name.each { |b| branch_names << {b, b} }

    return branch_names
  end
end
