class CreateIssue < Issue::SaveOperation
  permit_columns name, description

  needs repo_id : Int64

  before_save do
    AvramScopeId.set column: scoped_id,
      query: IssueQuery.new.repository_id(repo_id.not_nil!)
  end
end
