# frozen_string_literal: true

class Post < ApplicationRecord
  include PostsHelper
  belongs_to :account
  has_many :photos, dependent: :destroy, as: :imageable
  has_many :likes, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :comments, -> { order(created_at: :desc) }, dependent: :destroy

  validates :account_id, presence: true

  # def belongs_to?(account)
  #   Post.find_by(account_id: account.id, id: id)
  # end
  #
  # def is_liked(account)
  #   Like.find_by(account_id: account.id, post_id: id)
  # end
end
