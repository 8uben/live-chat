class MessagesController < ApplicationController
  def create
    @room = Room.find_by(id: params[:room_id])

    return head :bad_request unless @room.present?
    return head :forbidden unless can_send_message_to_room?

    @message = Message.new(message_params)

    if @message.save
      # NOTE: maybe to call broadcast from job?
      RoomChannel.broadcast_to(@room, { template: render_to_string(@message), message: @message })
      render @message
    else
      head :bad_request
    end
  end

  private

  def message_params
    params.require(:message).permit(:content).with_defaults(user_id: current_user.id,
                                                            room_id: params[:room_id])
  end

  def can_send_message_to_room?
    return true if @room.is_public?

    @room.title.split('dialog').last.split('-').map(&:to_i).include?(current_user.id)
  end
end
