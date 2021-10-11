class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  # アソシエーション
  has_many :phrases
  has_many :knowledges
  has_many :comments
  has_many :group_users
  has_many :favorites
  has_many :bookmarks
  has_many :messages
  has_many :entries
  # relationshipはまだ
  
  
end
