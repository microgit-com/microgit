class User < BaseModel
  include Carbon::Emailable
  include Authentic::PasswordAuthenticatable

  table do
    column email : String
    column username : String
    column encrypted_password : String
    column confirmed_at : Time?
    column confirmed_token : String
    has_one namespace : Namespace
    has_many api_tokens : ApiToken
    has_many team_members : TeamMembers
    has_many teams : Team, through: [:team_members, :team]
  end

  def confirmed?
    !confirmed_at.nil?
  end

  def slug
    namespace!.slug
  end

  def profile_pic_url
    # create the md5 hash
    hash = Digest::MD5.hexdigest(email.downcase)

    # compile URL which can be used in <img src="RIGHT_HERE"...
    "https://www.gravatar.com/avatar/#{hash}"
  end

  def emailable : Carbon::Address
    Carbon::Address.new(email)
  end
end
