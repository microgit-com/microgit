class Repositories::Update < BrowserAction
  route do
    repository = RepositoryQuery.find(repository_id)
    SaveRepository.update(repository, params) do |operation, repository|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Show.with(repository.namespace_slug, repository.slug)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, repository: repository
      end
    end
  end
end
