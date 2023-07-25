require "application_system_test_case"

class MessagesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @message = "Hello, #{users(:companion).username}!"
    @input_placeholder = 'Enter text'
  end

  test 'should to show own new message in the room' do
    user = users(:user1)
    companion = users(:companion)

    sign_in user

    visit root_path
    click_link companion.username

    send_message(@message)

    assert_empty find_field(@input_placeholder).value
    assert_text @message
  end

  test "should to show companion's new message in the room" do
    # TODO:
    # pending...
  end

  test 'should to show new messages after returning to the room' do
    user = users(:user1)
    room = rooms(:public)

    sign_in user

    visit root_path

    2.times do
      click_link room.title
    end

    send_message(@message)

    assert_empty find_field(@input_placeholder).value
    assert_text @message
  end

  test 'new room added to list of public rooms' do
    room_title = rooms(:public).title

    sign_in users(:user1)

    visit root_path

    fill_in 'room_title', with: room_title
    click_button 'Create room'

    within('ul[data-room-list-target="publicList"]') do
      assert_text room_title
    end
  end

  private

  def send_message(message)
    fill_in @input_placeholder, with: message
    click_button 'Create Message'
  end
end
