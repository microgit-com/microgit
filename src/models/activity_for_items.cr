class ActivityForItems < BaseModel
  avram_enum Type do
    Comment = 0
  end

  table do
    column type : ActivityForItems::AvramType
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
