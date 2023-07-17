class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = Room.find(params[:room_id])
    stream_for room
  rescue ActiveRecord::RecordNotFound
    reject
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
