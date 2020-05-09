class SignUpUser < User::SaveOperation
  param_key :user
  # Change password validations in src/operations/mixins/password_validations.cr
  include PasswordValidations
  after_save :save_namespace
  after_save :send_invite_email

  permit_columns email, username
  attribute password : String
  attribute password_confirmation : String

  before_save do
    validate_required username
    validate_uniqueness_of email
    validate_uniqueness_of username
    confirmed_token.value = Random::Secure.hex(32)
    Authentic.copy_and_encrypt password, to: encrypted_password
  end

  def send_invite_email(user)
    UserConfirmationEmail.new(user).deliver_later
  end

  def save_namespace(created_user : User)
    SaveNamespace.create!(name: created_user.username, user_id: created_user.id)
  end
end
