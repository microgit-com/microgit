class Repositories::Create < BrowserAction
  route do
    SaveRepository.create(params, created_by_id: current_user.id, user_id: current_user.id) do |operation, repository|
      if repository
        repository = RepositoryQuery.new.preload_user.preload_team.find(repository.id)
        repo = Git::Repo.init_at(repository.git_path, true)
        hooks = CreateHooks.new(repository)
        hooks.create_all_hooks
        flash.success = "The record has been saved"
        redirect Show.with(repository.namespace_slug, repository.slug)
      else
        flash.failure = "It looks like the form is not valid"
        html NewPage, operation: operation
      end
    end
  end
end
