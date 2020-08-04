class Issue < BaseModel
  avram_enum Status do
    Opened
    Closed
  end

  table do
    column name : LuckyEncrypted::StringEncrypted
    column description : String
    belongs_to repository : Repository
    belongs_to author : User
    belongs_to assignee : User?
    column status : Issue::AvramStatus
    column scoped_id : Int64
  end
end
