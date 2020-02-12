class Repositories::Issues::Create < BrowserAction
  nested_route do
    repository = RepositoryQuery.new.preload_user.preload_team.find(repository_id)
    SaveIssue.create(params, repository_id: repository.id, author_id: current_user.id) do |operation, issue|
      if issue
        flash.success = "The record has been saved"
        redirect Show.with(repository.namespace_slug, repository.slug, issue.id)
      else
        flash.failure = "It looks like the form is not valid"
        html NewPage, operation: operation, issue: issue, repository: repository
      end
    end
  end
end
