class Namespaces::Update < BrowserAction
  route do
    namespace = NamespaceQuery.find(namespace_id)
    SaveNamespace.update(namespace, params) do |operation, namespace|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Show.with(namespace.id)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, namespace: namespace
      end
    end
  end
end
