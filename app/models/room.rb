class Room < ApplicationRecord
  validates :title, presence: true, uniqueness: true
end
