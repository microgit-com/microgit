class Namespaces::Delete < BrowserAction
  route do
    NamespaceQuery.find(namespace_id).delete
    flash.success = "Deleted the record"
    redirect Index
  end
end
