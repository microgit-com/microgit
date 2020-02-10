class Namespaces::New < BrowserAction
  route do
    html NewPage, operation: SaveNamespace.new
  end
end
