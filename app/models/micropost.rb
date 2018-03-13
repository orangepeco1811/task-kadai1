class Micropost < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }

  
  has_many :favorites
  has_many :favers, through: :favorites, source: :user
  has_many :favorites , dependent: :destroy

end