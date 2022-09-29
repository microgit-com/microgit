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
    confirm_token = Random::Secure.hex(32)
    confirmed_token.value = confirm_token
    if LuckyEnv.development?
      puts "Confirmation token: #{confirm_token}"
      puts "Go to #{UserConfirmations::Show.url(token: confirm_token)}"
    end
    Authentic.copy_and_encrypt password, to: encrypted_password
  end

  def send_invite_email(user)
    UserConfirmationEmail.new(user).deliver_later
  end

  def save_namespace(created_user : User)
    SaveNamespace.create!(name: created_user.username, user_id: created_user.id)
  end
end
