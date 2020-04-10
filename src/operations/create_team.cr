class CreateTeam < Team::SaveOperation
  needs created_by : User
  permit_columns name, description
  after_save :save_namespace
  after_save :save_team_member

  def save_namespace(created_team : Team)
    SaveNamespace.create!(name: created_team.name, team_id: created_team.id)
  end

  def save_team_member(created_team : Team)
    SaveTeamMembers.create!(user_id: created_by.not_nil!.id, team_id: created_team.id, role: TeamMembers::AvramRole.new(:admin))
  end
end
