class Phrase < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :group
  has_many :bookmarks, dependent: :destroy
  has_many :knowledges, dependent: :destroy
  
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end
end
