class Knowledge < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :phrase
  has_many :comments, dependent: :destroy
  
end
