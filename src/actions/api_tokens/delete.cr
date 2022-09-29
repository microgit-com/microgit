class ApiTokens::Delete < BrowserAction
  delete "/api_tokens/:api_token_id" do
    ApiTokenQuery.find(api_token_id).delete
    flash.success = "Deleted the record"
    redirect Index
  end
end
