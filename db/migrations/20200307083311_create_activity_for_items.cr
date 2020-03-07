class CreateActivityForItems::V20200307083311 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(ActivityForItems) do
      primary_key id : Int64
      add_timestamps
      add type : Int32
      add text : String
      add_belongs_to user : User, on_delete: :cascade
      add_belongs_to merge_request : MergeRequest?, on_delete: :cascade
      add_belongs_to issue : Issue?, on_delete: :cascade
    end
  end

  def rollback
    drop table_for(ActivityForItems)
  end
end
