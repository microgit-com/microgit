class Repositories::MergeRequests::NewPage < MainLayout
  needs operation : SaveMergeRequest
  needs repository : Repository
  needs namespace : Namespace
  quick_def page_title, "New"

  def content
    h1 "New"
    render_merge_request_form(@operation)
  end

  def render_merge_request_form(op)
    form_for MergeRequests::Create.with(@namespace.slug, @repository.slug) do
      mount Shared::Field.new(op.name)
      mount Shared::Field.new(op.description)
      mount Shared::Field.new(op.branch)
      #select_tag(op.branch) do
      #  options_for_select(op.branch, options_for_branches)
      #end

      submit "Save", data_disable_with: "Saving..."
    end
  end

  private def options_for_branches
    return [{"master", "master"}]
  end
end
