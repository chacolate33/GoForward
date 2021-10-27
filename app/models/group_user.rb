class GroupUser < ApplicationRecord
  # アソシエーション
  belongs_to :group
  belongs_to :user

  # バリデーション
  validates :user_id, presence: true
  validates :group_id, presence: true
  validates :user_id, uniqueness: {scope: :group_id}
  validates :group_id, uniqueness: {scope: :user_id}
end

