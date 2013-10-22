if @saved_successfully
  json.response do
    json.(@user, :id, :email)
  end
else
  json.errors @user.errors
end
