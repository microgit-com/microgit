class CreateUserInvitations::V20200321080511 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(UserInvitation) do
      primary_key id : Int64
      add_timestamps
      add sent_at : Time
      add token : String
      add invitee_email : String
      add accepted_at : Time?
      add_belongs_to inviter : User, on_delete: :cascade
      add_belongs_to team : Team, on_delete: :cascade
    end
  end

  def rollback
    drop table_for(UserInvitation)
  end
end
