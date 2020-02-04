class CreateRepositories::V20200204084903 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(Repository) do
      primary_key id : Int64
      add_timestamps
      add name : String
      add description : String?
      add slug : String
      add privated : Bool, default: false
      add_belongs_to user : User, on_delete: :cascade
    end
  end

  def rollback
    drop table_for(Repository)
  end
end
