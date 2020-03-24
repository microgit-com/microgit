class TeamMembers < BaseModel
  avram_enum Role do
    User
    Admin
  end

  table do
    belongs_to user : User
    belongs_to team : Team
    column role : TeamMembers::AvramRole
  end
end
