class CreateTeams::V20200210192913 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(Team) do
      primary_key id : Int64
      add_timestamps
      add name : String
      add slug : String
      add description : String
    end
  end

  def rollback
    drop table_for(Team)
  end
end
