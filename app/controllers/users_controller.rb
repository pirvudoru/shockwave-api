class UsersController < ApplicationController
  respond_to :json

  def create
    respond_with User.new
  end
end