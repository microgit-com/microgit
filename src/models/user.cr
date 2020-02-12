class User < BaseModel
  include Carbon::Emailable
  include Authentic::PasswordAuthenticatable

  table do
    column email : String
    column username : String
    column encrypted_password : String
    has_one namespace : Namespace
    has_many apit_tokens : ApiToken
  end

  def slug
    namespace.slug
  end

  def emailable : Carbon::Address
    Carbon::Address.new(email)
  end
end
