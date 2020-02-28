class Issue < BaseModel
  enum Status
    Open
    Close
  end

  table do
    column name : LuckyEncrypted::StringEncrypted
    column description : String
    belongs_to repository : Repository
    belongs_to author : User
    belongs_to assignee : User?
    column status : Int32
  end
end
