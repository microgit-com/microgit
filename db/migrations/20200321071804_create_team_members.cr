class CreateTeamMembers::V20200321071804 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(TeamMembers) do
      primary_key id : Int64
      add_timestamps
      add_belongs_to user : User, on_delete: :cascade
      add_belongs_to team : Team, on_delete: :cascade
    end
  end

  def rollback
    drop table_for(TeamMembers)
  end
end
