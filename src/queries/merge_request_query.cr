class MergeRequestQuery < MergeRequest::BaseQuery
  def find_scoped(scoped_id : Int64) : MergeRequest
    scoped_id(scoped_id).first
  end
end
