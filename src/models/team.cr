class Team < BaseModel
  table do
    column name : String
    column description : String
    has_one namespace : Namespace
  end

  def slug
    namespace.slug
  end
end
