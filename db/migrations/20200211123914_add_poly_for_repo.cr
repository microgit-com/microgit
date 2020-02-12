class AddPolyForRepo::V20200211123914 < Avram::Migrator::Migration::V1
  def migrate
    alter :repositories do
      add_belongs_to team : Team?, on_delete: :cascade
      add_belongs_to created_by : User, on_delete: :cascade
    end
  end

  def rollback
    # drop table_for(Thing)
  end
end
