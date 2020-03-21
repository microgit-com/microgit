class TeamMembers < BaseModel
  table do
    belongs_to user : User
    belongs_to team : Team
  end
end
