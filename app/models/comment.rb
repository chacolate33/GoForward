class Comment < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :knowledge

  # バリデーション
  validates :content, presence: true
end
