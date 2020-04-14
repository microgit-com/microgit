class Repositories::MergeRequests::Activities::Create < RepositoryAction

  post "/:namespace_slug/:repository_slug/merge_requests/:merge_request_id/comment" do
    merge_request = MergeRequestQuery.find(merge_request_id)
    SaveActivityForItems.create(params, merge_request_id: merge_request.id, user_id: current_user.id, type: ActivityForItems::AvramType.new(:comment)) do |operation, comment|
      if comment
        flash.success = "The record has been saved"
        redirect MergeRequests::Show.with(@repository.not_nil!.namespace_slug, @repository.not_nil!.slug, merge_request.id)
      else
        flash.failure = "It looks like the form is not valid"
        comments = ActivityForItemsQuery.new.preload_user.merge_request_id(merge_request_id)
        begin
          repo = MicrogitGit.new(@repository.not_nil!)
        rescue Exception
          raise Lucky::RouteNotFoundError.new(context)
        end

        target = Git::Branch.lookup(repo.raw, merge_request.branch)

        diff = repo.get_branch_diff(target)

        ahead, behind = repo.ahead_behind_branch(target)

        html MergeRequests::ShowPage, operation: operation, diff: diff, ahead: ahead, behind: behind, merge_request: merge_request, repository: @repository.not_nil!, namespace: @namespace.not_nil!, comments: comments
      end
    end
  end
end
