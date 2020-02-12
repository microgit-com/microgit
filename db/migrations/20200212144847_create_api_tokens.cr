class CreateApiTokens::V20200212144847 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(ApiToken) do
      primary_key id : Int64
      add_timestamps
      add token : String
      add_belongs_to user : User, on_delete: :cascade
    end
  end

  def rollback
    drop table_for(ApiToken)
  end
end
