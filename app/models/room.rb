class Room < ApplicationRecord
  has_many :messages, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  # TODO: remove left and right white spaces in title
end
