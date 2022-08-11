class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates_uniqueness_of :username

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :stories, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  scope :has_stories, -> {where ('EXISTS(SELECT * FROM stories WHERE account_id = accounts.id)')}
end
