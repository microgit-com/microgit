class SaveIssue < Issue::SaveOperation
  permit_columns name, description
end
