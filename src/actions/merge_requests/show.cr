class Repositories::MergeRequests::Show < BrowserAction
  include Auth::AllowGuests
  include RepositoryHelper
  get "/:namespace_slug/:repository_slug/merge_requests/:merge_request_id" do
    merge_request = MergeRequestQuery.new.preload_author.find(merge_request_id)
    repository = check_access
    namespace = get_namespace

    begin
      repo = MicrogitGit.new(repository)
    rescue Exception
      raise Lucky::RouteNotFoundError.new(context)
    end

    target = Git::Branch.lookup(repo.raw, merge_request.branch)

    diff = repo.get_branch_diff(target)

    ahead, behind = repo.ahead_behind_branch(target)

    comments = ActivityForItemsQuery.new.preload_user.merge_request_id(merge_request_id)
    html ShowPage, operation: SaveActivityForItems.new, merge_request: merge_request, diff: diff, ahead: ahead, behind: behind, repository: repository, namespace: namespace, comments: comments
  end
end
