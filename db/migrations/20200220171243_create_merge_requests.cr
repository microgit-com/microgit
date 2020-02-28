class CreateMergeRequests::V20200220171243 < Avram::Migrator::Migration::V1
  def migrate
    create table_for(MergeRequest) do
      primary_key id : Int64
      add_timestamps
      add name : String
      add description : String
      add branch : String
      add status : Int32
      add_belongs_to repository : Repository, on_delete: :do_nothing
      add_belongs_to author : User, on_delete: :do_nothing
      add_belongs_to assignee : User?, on_delete: :do_nothing
    end
  end

  def rollback
    drop table_for(MergeRequest)
  end
end
