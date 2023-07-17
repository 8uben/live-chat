module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_current_user
    end

    private

    def find_current_user
      env['warden']&.user.presence ||
        User.find_by(id: cookies[:user_id]) ||
        reject_unauthorized_connection
    end
  end
end
