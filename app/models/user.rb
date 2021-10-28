class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :phrases
  has_many :knowledges
  has_many :comments
  has_many :group_users, dependent: :destroy
  has_many :applies, dependent: :destroy
  has_many :groups, through: :group_users
  has_many :favorites, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  # バリデーション
  validates :name, presence: true

  # 画像up用
  attachment :image

  # フォロー機能
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  # フォローを外す機能
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  # フォローする/外すボタンの表示を分けるための記載
  def following?(user)
    followings.include?(user)
  end

  # 退会済みアカウントが同じアカウントでログインできないようにする制約
  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  # 検索用
  def self.search_for(value)
    User.where('name LIKE?', '%' + value + '%')
  end
end
