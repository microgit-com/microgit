class Team < BaseModel
  table do
    column name : String
    column slug : String
    column description : String
  end
end
