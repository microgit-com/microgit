class SignUpUser < User::SaveOperation
  param_key :user
  # Change password validations in src/operations/mixins/password_validations.cr
  include PasswordValidations

  permit_columns email, username
  attribute password : String
  attribute password_confirmation : String

  before_save do
    validate_uniqueness_of email
    validate_uniqueness_of username
    Authentic.copy_and_encrypt password, to: encrypted_password
  end
end
