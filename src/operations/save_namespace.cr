class SaveNamespace < Namespace::SaveOperation
  permit_columns name

  before_save do
    slug.value = Sluggr.slugify(name.value || "")
    validate_uniqueness_of slug
  end
end
