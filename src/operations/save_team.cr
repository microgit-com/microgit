class SaveTeam < Team::SaveOperation
  permit_columns name, description


  before_save do
    slug.value = Sluggr.slugify(name.value || "")
    validate_uniqueness_of slug
  end
end
