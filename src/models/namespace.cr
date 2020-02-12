class Namespace < BaseModel
  table do
    column name : String
    column slug : String

    belongs_to team : Team?
    belongs_to user : User?

    polymorphic item, associations: [:user, :team]
  end
end
