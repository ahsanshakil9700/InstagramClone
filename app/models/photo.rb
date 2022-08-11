class Photo < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  validates :image, presence: true
  mount_uploader :image, PhotoUploader
end
