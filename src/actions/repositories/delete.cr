class Repositories::Delete < BrowserAction
  route do
    repo = RepositoryQuery.find(repository_id)
    repo.remove_data
    repo.delete
    flash.success = "Deleted the record"
    redirect Index
  end
end
