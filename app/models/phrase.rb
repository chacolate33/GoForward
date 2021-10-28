class Phrase < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :group
  has_many :bookmarks, dependent: :destroy
  has_many :knowledges, dependent: :destroy
  has_many :posted_phrases, through: :knowledges, source: :user

  # バリデーション
  validates :content, presence: true
  validates :japanese, presence: true

  # current_userがブックマークしているかそうでないかでviewを変える
  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  # 検索用
  def self.search_for(value)
    Phrase.where('content LIKE ?', '%' + value + '%')
  end
end
