class AddDefaultToIssueStatus::V20200310070026 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(MergeRequest) do
      remove :status
      add status : Int32, default: 0
    end
  end

  def rollback
    # drop table_for(Thing)
  end
end
