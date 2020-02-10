class Teams::New < BrowserAction
  route do
    html NewPage, operation: SaveTeam.new
  end
end
