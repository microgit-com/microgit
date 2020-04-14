class Repositories::Issues::Create < RepositoryAction
  post "/:namespace_slug/:repository_slug/issues" do
    namespace = get_namespace
    SaveIssue.create(params, repository_id: @repository.not_nil!.id, author_id: current_user.id, status: Issue::AvramStatus.new(:opened)) do |operation, issue|
      if issue
        flash.success = "The record has been saved"
        redirect Show.with(@repository.not_nil!.namespace_slug, @repository.not_nil!.slug, issue.id)
      else
        flash.failure = "It looks like the form is not valid"
        html NewPage, operation: operation, issue: issue, repository: @repository.not_nil!
      end
    end
  end
end
