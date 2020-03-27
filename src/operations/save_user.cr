class SaveUser < User::SaveOperation
  permit_columns username, email

  before_save do
    validate_required username
    validate_required email
    validate_uniqueness_of email
    validate_uniqueness_of username
  end

  after_save :update_namespace

  def update_namespace(created_user : User)
    SaveNamespace.update!(created_user.namespace!, name: created_user.username)
  end
end
