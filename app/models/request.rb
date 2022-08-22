# frozen_string_literal: true

class Request < ApplicationRecord

  belongs_to :sender, foreign_key: 'account_id', class_name: 'Account'
  belongs_to :sending, foreign_key: 'following_id', class_name: 'Account'

  scope :pending_requests, ->(id) { where(following_id: id) }

  validates :account_id, :following_id, presence: true
end
