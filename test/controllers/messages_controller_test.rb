require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:user1)
    @message_params = { message: { content: 'Hello!' } }
  end

  test 'when message sent to public room' do
    post room_messages_path(room_id: rooms(:public).id), params: @message_params

    assert_response :success
  end

  test 'when message sent to private room' do
    post room_messages_path(room_id: rooms(:private).id), params: @message_params

    assert_response :success
  end

  test 'when message sent to not exist room' do
    post room_messages_path(0), params: @message_params

    assert_response :bad_request
  end

  test 'when message sent to another private room' do
    post room_messages_path(room_id: rooms(:another_private)), params: @message_params

    assert_response :forbidden
  end
end
