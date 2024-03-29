# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :post
  belongs_to :account

  # validates :account_id, uniqueness: { scope: :post_id } # user can like a post only once
  validates :account_id, :post_id, presence: true
end
