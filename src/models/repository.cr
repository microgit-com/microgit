class Repository < BaseModel
  table do
    column name : String
    column description : String?
    column slug : String
    column privated : Bool
    belongs_to user : User
  end
end
