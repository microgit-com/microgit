class SaveRepository < Repository::SaveOperation
  permit_columns name, description, privated

  before_save do
    slug.value = Sluggr.slugify(name.value || "")
    validate_uniqueness_of slug
  end
end
