class CreateNamespaces::V20200210193157 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(Namespace) do
      primary_key id : Int64
      add_timestamps
      add name : String
      add slug : String
    end
  end

  def rollback
    drop table_for(Namespace)
  end
end
