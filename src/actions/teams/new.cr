class Teams::New < BrowserAction
  get "/teams/new" do
    html NewPage, operation: CreateTeam.new(created_by: current_user)
  end
end
