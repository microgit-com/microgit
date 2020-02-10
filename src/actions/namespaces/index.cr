class Namespaces::Index < BrowserAction
  route do
    html IndexPage, namespaces: NamespaceQuery.new
  end
end
