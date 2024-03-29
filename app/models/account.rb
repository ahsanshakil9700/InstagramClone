# frozen_string_literal: true

class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable

  validates :username, uniqueness: true

  include Searchable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :stories, dependent: :destroy

  has_many :follows, dependent: :destroy
  has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow'
  has_many :followers, through: :follower_relationships
  has_many :following_relationships, class_name: 'Follow'
  has_many :following, through: :following_relationships

  has_many :requests, dependent: :destroy
  has_many :sender_relationships, foreign_key: :following_id, class_name: 'Request'
  has_many :senders, through: :sender_relationships
  has_many :sending_relationships, class_name: 'Request'
  has_many :sending, through: :sending_relationships

  mount_uploader :avatar, AvatarUploader

  validates :full_name, :email, presence: true, length: { maximum: 50 }

end
