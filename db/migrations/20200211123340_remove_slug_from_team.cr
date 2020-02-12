class RemoveSlugFromTeam::V20200211123340 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(Team) do
      remove :slug
    end
  end

  def rollback
    # drop table_for(Thing)
  end
end
