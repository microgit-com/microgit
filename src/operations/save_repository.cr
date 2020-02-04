class SaveRepository < Repository::SaveOperation
  permit_columns name, description, privated, slug
  before_save do
    validate_uniqueness_of slug
  end
end
