class Repositories::Update < BrowserAction
  route do
    new_repository = RepositoryQuery.new.preload_user.preload_team.find(repository_id)
    SaveRepository.update(new_repository, params) do |operation, repository|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Show.with(new_repository.namespace_slug, repository.slug)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, repository: repository
      end
    end
  end
end
