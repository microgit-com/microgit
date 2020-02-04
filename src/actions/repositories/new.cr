class Repositories::New < BrowserAction
  route do
    html NewPage, operation: SaveRepository.new
  end
end
