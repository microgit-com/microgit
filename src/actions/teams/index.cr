class Teams::Index < BrowserAction
  route do
    html IndexPage, teams: TeamQuery.new.preload_namespace
  end
end
