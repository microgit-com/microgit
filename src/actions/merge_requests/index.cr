class Repositories::MergeRequests::Index < RepositoryAction
  include Auth::AllowGuests

  get "/:namespace_slug/:repository_slug/merge_requests" do
    html IndexPage, merge_requests: MergeRequestQuery.new.preload_author, repository: @repository.not_nil!, namespace: @namespace.not_nil!
  end
end
