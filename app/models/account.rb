class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates_uniqueness_of :username

  has_many :posts, dependent: :destroy
  has_many :likes
  has_many :comments

  mount_uploader :avatar, AvatarUploader
end
