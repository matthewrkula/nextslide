class Api::V1::UserApiKeysController < ApplicationController
  def create
    user = User.where(email: params[:user_api_key][:email]).first
    @user_api_key = UserApiKey.new(user_id: user.id)
    if @user_api_key.save
      @saved_successfully = true
      response.headers['Authorization-Token'] = @user_api_key.access_token
      render status: 201
    else
      @saved_successfully = false
      render status: 422
    end
  end
end
