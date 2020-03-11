class MergeRequest < BaseModel
  enum Status : Int32
    Open
    Close
    Merged
  end

  table do
    column name : LuckyEncrypted::StringEncrypted
    column description : String
    column branch : String
    column status : Int32
    belongs_to repository : Repository
    belongs_to author : User
  end
end
