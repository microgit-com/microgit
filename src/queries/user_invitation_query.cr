class UserInvitationQuery < UserInvitation::BaseQuery
  def from_token(token_value : String)
    token(token_value).sent_at.gt(1.week.ago) # Set an expiration
  end
end
