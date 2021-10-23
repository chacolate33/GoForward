class Bookmark < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :phrase
  # バリデーション
  # 重複登録を防ぐ
  validates :user_id, uniqueness: {scope: :phrase_id}
end
