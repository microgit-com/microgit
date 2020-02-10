class Teams::Index < BrowserAction
  route do
    html IndexPage, teams: TeamQuery.new
  end
end
