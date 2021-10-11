class Bookmark < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :phrase
end
