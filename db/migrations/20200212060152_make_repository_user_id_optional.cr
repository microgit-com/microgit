class MakeRepositoryUserIdOptional::V20200212060152 < Avram::Migrator::Migration::V1
  def migrate
    make_optional :repositories, :user_id
  end

  def rollback
    # drop table_for(Thing)
  end
end
