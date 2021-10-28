class Message < ApplicationRecord
  # アソシエーション
  belongs_to :room
  belongs_to :user

  # バリデーション
  validates :content, presence: true
end
