class SaveMergeRequest < MergeRequest::SaveOperation
  permit_columns name, description, branch, status
end
