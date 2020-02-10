class Namespaces::Edit < BrowserAction
  route do
    namespace = NamespaceQuery.find(namespace_id)
    html EditPage,
      operation: SaveNamespace.new(namespace),
      namespace: namespace
  end
end
