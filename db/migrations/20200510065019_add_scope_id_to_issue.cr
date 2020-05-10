class AddScopeIdToIssue::V20200510065019 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Issue) do
      add scoped_id : Int32, default: 0
    end
  end

  def rollback
    # drop table_for(Thing)
  end
end
