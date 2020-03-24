class AddRoleToTeamMembers::V20200324075849 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(TeamMembers) do
      add role : Int32, default: 0
    end
  end

  def rollback
    # drop table_for(Thing)
  end
end
