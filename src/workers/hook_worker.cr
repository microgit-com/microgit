class HookWorker < Mosquito::QueuedJob
  params id : Int32
  params oldrev : String
  params newrev : String
  params reference : String

  def perform(id, oldrev, newrev, reference)
    repository = RepositoryQuery.new.find(id)

  end
end
