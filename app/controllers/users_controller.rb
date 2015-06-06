class UsersController < ApplicationController
  respond_to :json

  def create
    respond_with User.create!(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phone_number)
  end
end