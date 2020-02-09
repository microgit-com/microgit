class CreateIssues::V20200208232607 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(Issue) do
      primary_key id : Int64
      add_timestamps
      add name : String
      add description : String
      add_belongs_to repository : Repository, on_delete: :do_nothing
      add_belongs_to author : User, on_delete: :do_nothing
      add_belongs_to assignee : User?, on_delete: :do_nothing
    end
  end

  def rollback
    drop table_for(Issue)
  end
end
