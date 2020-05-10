class IssueQuery < Issue::BaseQuery
  def find_scoped(scoped_id : Int64) : Issue
    scoped_id(scoped_id).first
  end
end
