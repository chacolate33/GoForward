class Room < ApplicationRecord
  # アソシエーション
  has_many :messages
  has_many :entries
end
