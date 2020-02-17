class SaveRepository < Repository::SaveOperation
  permit_columns name, description, privated

  before_save do
    validate_required name
    slug.value = Sluggr.slugify(name.value || "")
    if team_id.value
      validate_uniqueness_of slug, query: RepositoryQuery.new.team_id.nilable_eq(team_id.value).slug
    elsif user_id.value
      validate_uniqueness_of slug, query: RepositoryQuery.new.user_id.nilable_eq(user_id.value).slug
    end
  end
end
