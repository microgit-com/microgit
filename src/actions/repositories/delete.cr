class Repositories::Delete < BrowserAction
  route do
    RepositoryQuery.find(repository_id).delete
    flash.success = "Deleted the record"
    redirect Index
  end
end
