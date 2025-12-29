class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true, length: { maximum: 140 }
  has_one_attached :image
  validate :image_type, if: -> { image.attached? }
  validate :image_size, if: -> { image.attached? }
end