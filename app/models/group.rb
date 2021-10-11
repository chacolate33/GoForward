class Group < ApplicationRecord
  # アソシエーション
  has_many :group_users
  has_many :phrases
  attachment :image
end
