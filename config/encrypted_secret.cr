LuckyEncrypted.configure do |settings|
  settings.secret = if LuckyEnv.production?
    ENV["LUCKY_SECRET_KEY"]
  else
    "9nzg+bfn/ReCo598bJA/RJSugQ9v+UsLQ0xRJikJGWo="
  end
end
