class Api::V1::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    render status: 200
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      @saved_successfully = true
      render status: 201
    else
      @saved_successfully = false
      render status: 422
    end
  end
end
