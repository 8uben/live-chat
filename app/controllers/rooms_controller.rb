class RoomsController < ApplicationController
  def index
    @users = User.without(current_user)
    @rooms = Room.groups
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      render @room
    else
      head :bad_request
    end
  end

  private

  def room_params
    params.require(:room).permit(:title)
  end
end
