class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @room = Room.find_or_create_private_room(@user.id, current_user.id)
    @message = Message.new

    render 'rooms/show'
  end
end
