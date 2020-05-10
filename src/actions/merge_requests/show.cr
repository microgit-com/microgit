class Repositories::MergeRequests::Show < RepositoryAction
  include Auth::AllowGuests
  get "/:namespace_slug/:repository_slug/merge_requests/:merge_request_id" do
    merge_request = MergeRequestQuery.new.preload_author.repository_id(@repository.not_nil!.id).find_scoped(merge_request_id.to_i64)

    begin
      repo = MicrogitGit.new(@repository.not_nil!)
    rescue Exception
      raise Lucky::RouteNotFoundError.new(context)
    end

    target = Git::Branch.lookup(repo.raw, merge_request.branch)

    diff = repo.get_branch_diff(target)

    ahead, behind = repo.ahead_behind_branch(target)

    comments = ActivityForItemsQuery.new.preload_user.merge_request_id(merge_request.id)
    html ShowPage, operation: SaveActivityForItems.new, merge_request: merge_request, diff: diff, ahead: ahead, behind: behind, repository: @repository.not_nil!, namespace: @namespace.not_nil!, comments: comments
  end
end
