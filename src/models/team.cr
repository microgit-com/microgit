class Team < BaseModel
  table do
    column name : String
    column description : String
    has_one namespace : Namespace
    has_many repositories : Repository
    has_many team_members : TeamMembers
    has_many users : User, through: [:team_members, :user]
  end

  def slug
    namespace!.slug
  end
end
