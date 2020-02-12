class AddNameToNamespaces::V20200211115056 < Avram::Migrator::Migration::V1
  def migrate
    alter :namespaces do

         # Or if this is a column for a belongs_to relationship:
         add_belongs_to team : Team?, on_delete: :cascade
         add_belongs_to user : User?, on_delete: :cascade
       end
    # execute "CREATE UNIQUE INDEX things_title_index ON things (title);"
  end

  def rollback
    # drop table_for(Thing)
  end
end
