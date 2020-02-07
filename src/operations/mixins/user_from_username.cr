module UserFromUsername
  private def user_from_username : User?
    username.value.try do |value|
      UserQuery.new.username(value).first?
    end
  end
end
