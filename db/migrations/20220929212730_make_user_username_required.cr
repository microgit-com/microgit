class MakeUserUsernameRequired::V20220929212730 < Avram::Migrator::Migration::V1
  def migrate
    make_required table_for(User), :username
  end

  def rollback
    make_optional table_for(User), :username
  end
end
