class ApiTokens::Index < BrowserAction
  route do
    html IndexPage, api_tokens: ApiTokenQuery.new.user_id(current_user.id)
  end
end
