class Issue < BaseModel
  table do
    column name : String
    column description : String
    belongs_to repository : Repository
    belongs_to author : User
    belongs_to assignee : User?
  end
end
