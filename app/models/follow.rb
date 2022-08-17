# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower, foreign_key: 'account_id', class_name: 'Account'
  belongs_to :following, class_name: 'Account'

  validates :account_id, :following_id, presence: true
end
