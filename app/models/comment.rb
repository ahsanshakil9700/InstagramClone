# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :account

  validates :account_id, :post_id, :content, presence: true
end
