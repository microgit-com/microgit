class MergeRequest < BaseModel
  avram_enum(Status) do
    Open = 0
    Closed = 1
    Merged = 2
  end

  table do
    column name : LuckyEncrypted::StringEncrypted
    column description : String
    column branch : String
    column status : MergeRequest::AvramStatus
    belongs_to repository : Repository
    belongs_to author : User
  end
end
