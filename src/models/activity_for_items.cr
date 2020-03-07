class ActivityForItems < BaseModel
  table do
    column type : Int32
    column text : String
    belongs_to user : User
    belongs_to merge_request : MergeRequest?
    belongs_to issue : Issue?
  end


  def item
    if !issue.nil?
      return issue
    elsif !merge_request.nil?
      return merge_request
    end
  end
end
