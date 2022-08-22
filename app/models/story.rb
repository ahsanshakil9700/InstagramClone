# frozen_string_literal: true

class Story < ApplicationRecord
  belongs_to :account
  has_many :photos, dependent: :destroy, as: :imageable

  validates :account_id, presence: true
end
