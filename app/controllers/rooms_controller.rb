class RoomsController < ApplicationController
  def index
    @users = User.without(current_user)
    @rooms = Room.all
  end

  def create
    Room.create(room_params)
  end

  private

  def room_params
    params.require(:room).permit(:title)
  end
end
