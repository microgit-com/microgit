class Repositories::Delete < RepositoryAction
  delete "/:namespace_slug/:repository_slug" do
    repo = get_repository
    repo.remove_data
    repo.delete
    flash.success = "Deleted the record"
    redirect Index
  end
end
