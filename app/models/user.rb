class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password


has_many :microposts
has_many :favorites
has_many :favings, through: :favorites, source: :micropost
  
  def fav(other_user)
    unless self == other_user
      self.favorites.find_or_create_by(micropost_id: other_user.id)
    end
  end

  def unfav(other_user)
    favorite = self.favorites.find_by(micropost_id: other_user.id)
    favorite.destroy if favorite
  end

  def faving?(micropost)
    self.favings.include?(micropost)
  end

  
end