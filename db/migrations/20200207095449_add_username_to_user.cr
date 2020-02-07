class AddUsernameToUser::V20200207095449 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(User) do
      add username : String?, fill_existing_with: "confact"
    end
  end

  def rollback
    # drop table_for(Thing)
  end
end
