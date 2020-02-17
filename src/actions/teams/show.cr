class Teams::Show < BrowserAction
  route do
    html ShowPage, team: TeamQuery.new.preload_namespace.preload_repositories.find(team_id), repositories: RepositoryQuery.new.preload_user.preload_team.team_id(team_id)
  end
end
