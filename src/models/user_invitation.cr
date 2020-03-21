class UserInvitation < BaseModel
  table do
    column sent_at : Time
    column token : String
    column invitee_email : String
    column accepted_at : Time?
    belongs_to inviter : User
    belongs_to team : Team
  end

  def accepted? : Bool
    !accepted_at.nil?
  end
end
