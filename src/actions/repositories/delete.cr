class Repositories::Delete < RepositoryAction
  delete "/:namespace_slug/:repository_slug" do
    @repository.not_nil!.remove_data
    @repository.not_nil!.delete
    flash.success = "Deleted the record"
    redirect Index
  end
end
