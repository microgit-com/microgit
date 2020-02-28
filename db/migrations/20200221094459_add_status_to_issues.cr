class AddStatusToIssues::V20200221094459 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Issue) do
      add status : Int32, default: 0
    end
  end

  def rollback
    # drop table_for(Thing)
  end
end
