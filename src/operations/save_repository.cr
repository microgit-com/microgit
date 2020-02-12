class SaveRepository < Repository::SaveOperation
  permit_columns name, description, privated

  before_save do
    validate_required name
    slug.value = Sluggr.slugify(name.value || "")
    validate_uniqueness_of slug
  end
end
