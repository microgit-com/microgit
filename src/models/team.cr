class Team < BaseModel
  table do
    column name : String
    column description : String
    has_one namespace : Namespace
    has_many repositories : Repository
  end

  def slug
    namespace.slug
  end
end
