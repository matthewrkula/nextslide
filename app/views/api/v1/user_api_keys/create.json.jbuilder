if @saved_successfully
  json.response do
    json.access_token @user_api_key.access_token
  end
else
  json.errors @user_api_key.errors
end
