class UpdateTeam < Team::SaveOperation
  permit_columns name, description
  after_save :save_namespace

  def save_namespace(created_team : Team)
    SaveNamespace.create!(name: created_team.name, team_id: created_team.id)
  end
end
