class CreateLabelInItems::V20200510060327 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(LabelInItem) do
      primary_key id : Int64
      add_belongs_to label : Label, on_delete: :cascade
      add_belongs_to merge_request : MergeRequest?, on_delete: :cascade
      add_belongs_to issue : Issue?, on_delete: :cascade
      add_timestamps
    end
  end

  def rollback
    drop table_for(LabelInItem)
  end
end
