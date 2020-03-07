class Repositories::Issues::Activities::Create < BrowserAction
  include RepositoryHelper
  post "/:namespace_slug/:repository_slug/issues/:issue_id/comment" do
    repository = check_access
    namespace = get_namespace
    issue = IssueQuery.new.preload_author.find(issue_id)
    SaveActivityForItems.create(params, issue_id: issue.id, user_id: current_user.id, type: 0) do |operation, comment|
      if comment
        flash.success = "The record has been saved"
        redirect Issues::Show.with(repository.namespace_slug, repository.slug, issue.id)
      else
        flash.failure = "It looks like the form is not valid"
        comments = ActivityForItemsQuery.new.preload_user.issue_id(issue_id)
        html Issues::ShowPage, operation: operation, issue: issue, repository: repository, namespace: namespace, comments: comments
      end
    end
  end
end
