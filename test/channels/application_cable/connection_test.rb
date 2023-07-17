require "test_helper"

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  test 'connection_success_when_cookie_is_set_correctly' do
    user = users(:user1)
    cookies[:user_id] = user.id

    connect

    assert_equal connection.current_user.id, user.id
  end

  test 'connection_rejected_without_cookie_set' do
    assert_reject_connection { connect }
  end
end
