class Repositories::Issues::Activities::Create < RepositoryAction
  post "/:namespace_slug/:repository_slug/issues/:issue_id/comment" do
    issue = IssueQuery.new.preload_author.find(issue_id)
    SaveActivityForItems.create(params, issue_id: issue.id, user_id: current_user.id, type: ActivityForItems::AvramType.new(:comment)) do |operation, comment|
      if comment
        flash.success = "The record has been saved"
        redirect Issues::Show.with(@repository.not_nil!.namespace_slug, @repository.not_nil!.slug, issue.id)
      else
        flash.failure = "It looks like the form is not valid"
        comments = ActivityForItemsQuery.new.preload_user.issue_id(issue_id)
        html Issues::ShowPage, operation: operation, issue: issue, repository: @repository.not_nil!, namespace: @namespace.not_nil!, comments: comments
      end
    end
  end
end
