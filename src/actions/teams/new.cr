class Teams::New < BrowserAction
  route do
    html NewPage, operation: CreateTeam.new(created_by: current_user)
  end
end
