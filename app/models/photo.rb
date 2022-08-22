# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :imageable, polymorphic: true
  validates :image, presence: true
  mount_uploader :image, PhotoUploader

  validate :check_image, on: :create

  def check_image
    return if image.filename

    raise StandardError, 'Please add images (at max 10)!'
  end
end
