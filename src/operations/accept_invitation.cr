class AcceptInvitation < User::SaveOperation
  include PasswordValidations

  permit_columns username
  attribute password : String
  attribute password_confirmation : String
  needs user_invitation : UserInvitation
  after_save :update_invitation
  after_save :add_to_team
  after_save :save_namespace

  before_save do
    email.value = @user_invitation.invitee_email
    validate_required username
    validate_uniqueness_of email
    validate_uniqueness_of username
    Authentic.copy_and_encrypt password, to: encrypted_password
  end

  def add_to_team(user)
    SaveTeamMembers.create!(team_id: @user_invitation.team_id, user_id: user.id)
  end

  def save_namespace(created_user : User)
    SaveNamespace.create!(name: created_user.username, user_id: created_user.id)
  end

  def update_invitation(user)
    UserInvitation::SaveOperation.update!(@user_invitation, accepted_at: Time.utc)
  end
end
