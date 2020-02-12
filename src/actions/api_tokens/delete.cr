class ApiTokens::Delete < BrowserAction
  route do
    ApiTokenQuery.find(api_token_id).delete
    flash.success = "Deleted the record"
    redirect Index
  end
end
