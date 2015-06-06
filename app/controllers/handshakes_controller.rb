class HandshakesController < ApplicationController
  respond_to :json

  before_filter :find_user

  def create
    @user.handshakes.create!(handshake_params)
    head 201
  end

  private

  def find_user
    begin
      @user = User.find(request.env['ACCESS_TOKEN'])
    rescue
      head 401
    end
  end

  def handshake_params
    params.require(:handshake).permit(:timestamp, location: [], acceleration_entries: [:x, :y, :z, :timestamp])
  end
end