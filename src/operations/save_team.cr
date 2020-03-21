class SaveTeam < Team::SaveOperation
  needs created_by : User, on: :create # can also be `:update`, `:save`
  permit_columns name, description
  after_save :save_namespace
  after_save :save_team_member

  def save_namespace(created_team : Team)
    SaveNamespace.create!(name: created_team.name, team_id: created_team.id)
  end

  def save_team_member(created_team : Team)
    unless created_by.nil?
      SaveTeamMembers.create!(user_id: created_by.not_nil!.id, team_id: created_team.id)
    end
  end
end
