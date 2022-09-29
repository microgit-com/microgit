class ApiTokens::Create < BrowserAction
  post "/api_tokens" do
    SaveApiToken.create(token: Random::Secure.base64, user_id: current_user.id) do |operation, api_token|
      if api_token
        flash.success = "The record has been saved"
        redirect Index
      else
        flash.failure = "It looks like the form is not valid"
        redirect Index
      end
    end
  end
end
