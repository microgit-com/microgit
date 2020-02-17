class Teams::Repositories::New < BrowserAction
  nested_route do
    html NewPage, operation: SaveRepository.new
  end
end
