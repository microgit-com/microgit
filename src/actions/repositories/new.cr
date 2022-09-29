class Repositories::New < BrowserAction
  get "/repositories/new" do
    html NewPage, operation: SaveRepository.new
  end
end
