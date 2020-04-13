class Repositories::Update < RepositoryAction
  put "/:namespace_slug/:repository_slug" do
    updating_repository = get_repository
    SaveRepository.update(updating_repository, params) do |operation, repository|
      if operation.saved?
        flash.success = "The record has been updated"
        redirect Show.with(updating_repository.namespace_slug, repository.slug)
      else
        flash.failure = "It looks like the form is not valid"
        html EditPage, operation: operation, repository: repository
      end
    end
  end
end
