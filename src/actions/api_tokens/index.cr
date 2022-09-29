class ApiTokens::Index < BrowserAction
  get "/api_tokens" do
    html IndexPage, api_tokens: ApiTokenQuery.new.user_id(current_user.id)
  end
end
