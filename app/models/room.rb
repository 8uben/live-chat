class Room < ApplicationRecord
  has_many :messages, dependent: :destroy

  scope :groups, -> { where(is_public: true) }

  validates :title, presence: true, uniqueness: true
  # TODO: remove left and right white spaces in title

  def self.find_or_create_private_room(first_user_id, second_user_id)
    title = "dialog#{[first_user_id, second_user_id].sort.join('-')}"

    Room.find_or_create_by(is_public: false, title: title)
  end
end
