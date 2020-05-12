class CreateLabels::V20200510055914 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Label) do
      primary_key id : Int64
      add name : String
      add color : String
      add_belongs_to repository : Repository, on_delete: :cascade
      add_timestamps
    end
  end

  def rollback
    drop table_for(Label)
  end
end
