class AddConfirmedAtToUser::V20200426071013 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(User) do
      add confirmed_at : Time?
      add confirmed_token : String, fill_existing_with: "test"
    end
  end

  def rollback
  end
end
