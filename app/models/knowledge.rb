class Knowledge < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :phrase
  has_many :comments, dependent: :destroy
  
  validates :content, presence: true
  
  enum status: [:意味・活用形, :イディオム, :例文, :成り立ち, :その他]
  
  def stats_str
    {意味・活用形: '意味・活用形', イディオム: 'イディオム', 例文: '例文', 成り立ち: '成り立ち', その他: 'その他'}[status.to_sym]
  end
  
end
