require "test_helper"

class RoomTest < ActiveSupport::TestCase
  test 'find_or_create_private_room' do
    assert_difference 'Room.count', 1, 'room has not been created' do
      Room.find_or_create_private_room(users(:user1).id, users(:user3).id)
    end

    assert_no_difference 'Room.count' do
      Room.find_or_create_private_room(users(:user1).id, users(:user2).id)
    end

    room = Room.find_or_create_private_room(users(:user1).id, users(:user3).id)

    assert_equal room.title, 'dialog1-3'
    assert_equal room.is_public?, false
  end
end
