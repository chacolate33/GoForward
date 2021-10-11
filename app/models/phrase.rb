class Phrase < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :group
  has_many :bookmarks
  has_many :favorites
  has_many :knowledges, dependent: :destroy
end
