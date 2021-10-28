class Knowledge < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :phrase
  has_many :favorites, dependent: :destroy
  has_many :favorited_knowledges, through: :favorites, source: :user
  has_many :comments, dependent: :destroy

  # バリデーション
  validates :content, presence: true

  # current_userがいいねしているかどうかでviewを変える
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  enum status: [:意味・活用形, :イディオム, :例文, :成り立ち, :その他]

  def stats_str
    {意味・活用形: '意味・活用形', イディオム: 'イディオム', 例文: '例文', 成り立ち: '成り立ち', その他: 'その他'}[status.to_sym]
  end

end
