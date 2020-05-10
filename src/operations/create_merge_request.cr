class CreateMergeRequest < MergeRequest::SaveOperation
  permit_columns name, description, branch, status

  needs repo_id : Int64

  before_save do
    AvramScopeId.set column: scoped_id,
      query: MergeRequestQuery.new.repository_id(repo_id.not_nil!)
  end
end
