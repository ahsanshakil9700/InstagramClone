class Story < ApplicationRecord
  belongs_to :account
  has_many :photos, dependent: :destroy, as: :imageable
end
