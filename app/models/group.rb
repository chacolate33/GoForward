class Group < ApplicationRecord
  # アソシエーション
  has_many :group_users, dependent: :destroy
  has_many :applies, dependent: :destroy
  has_many :phrases, dependent: :destroy
  has_many :users, through: :group_users
  # 画像up用
  attachment :image

  # バリデーション
  validates :name, length: { minimum: 2, maximum: 20 }
  validates :introduction, length: { minimum: 1, maximum: 255 }

  # 検索用
  def self.search_for(value)
    Group.where('name LIKE ?', '%' + value + '%')
  end
end
