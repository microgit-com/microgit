class Teams::Repositories::New < BrowserAction
  get "/teams/repositories/new" do
    html NewPage, operation: SaveRepository.new
  end
end
