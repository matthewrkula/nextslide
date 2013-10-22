class ApplicationController < ActionController::Base

  private

  def current_user
    authenticate_or_request_with_http_token do |token, options|
      user_api_key = UserApiKey.where(access_token: token).first
      @current_user = User.find(user_api_key.user_id)
    end
  end
end
