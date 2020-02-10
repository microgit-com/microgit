class Namespaces::Show < BrowserAction
  route do
    html ShowPage, namespace: NamespaceQuery.find(namespace_id)
  end
end
