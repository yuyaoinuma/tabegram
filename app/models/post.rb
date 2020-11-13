class Post < ApplicationRecord
  mount_uploader :image, ImageUploader

  
  belongs_to :user
  validates :content, presence: true, length: { maximum: 1000 }
  validates :image, presence: true
  
  has_many :favorites, dependent: :destroy
  has_many :likes, through: :favorites, source: :user

  
end
