require "test_helper"

class RoomChannelTest < ActionCable::Channel::TestCase
  setup do
    @room = rooms(:public_room)
  end

  test 'subscribes and stream for room' do
    subscribe room_id: @room.id

    assert_has_stream_for @room
  end

  test 'no subscription if incorrect room identifier' do
    subscribe room_id: 'incorrect data'

    assert_no_streams
  end

  test 'no subscription if room identifier is empty' do
    subscribe

    assert subscription.rejected?
  end

  test 'broadcast message to room' do
    assert_broadcast_on(RoomChannel.broadcasting_for(@room), 'Hello, world!') do
      RoomChannel.broadcast_to(@room, 'Hello, world!')
    end

    assert_broadcasts RoomChannel.broadcasting_for(@room), 1
  end

  test 'no send message if invalid room id' do
    assert_no_broadcasts RoomChannel.broadcasting_for(0)
    assert_no_broadcasts RoomChannel.broadcasting_for('1')
  end
end
