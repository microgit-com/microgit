class ChangeScopedIds::V20200804173003 < Avram::Migrator::Migration::V1
  def migrate
    alter table_for(MergeRequest) do
      # update your `id` column from postgres `integer` to `bigint`
      change_type scoped_id : Int64
    end
    alter table_for(Issue) do
      # update your `id` column from postgres `integer` to `bigint`
      change_type scoped_id : Int64
    end
  end

  def rollback
    # drop table_for(Thing)
  end
end
