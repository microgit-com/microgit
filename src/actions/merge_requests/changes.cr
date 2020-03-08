class Repositories::MergeRequests::Changes < BrowserAction
  include RepositoryHelper
  get "/:namespace_slug/:repository_slug/merge_requests/:merge_request_id/changes" do
    merge_request = MergeRequestQuery.new.preload_author.find(merge_request_id)
    repository = check_access
    namespace = get_namespace
    begin
      repo = MicrogitGit.new(repository)
    rescue Exception
      raise Lucky::RouteNotFoundError.new(context)
    end
    html ChangesPage, repo: repo, merge_request: merge_request, repository: repository, namespace: namespace
  end
end
