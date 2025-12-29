class Micropost < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true, length: { maximum: 140 }
  has_one_attached :image
  validate :image_type, :image_size

  private

  def image_type
    return unless image.attached?
    acceptable_types = ["image/jpeg", "image/png", "image/gif"]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be a valid image format")
    end
  end
  
  def image_size
    return unless image.attached?
    if image.byte_size > 5.megabytes
      errors.add(:image, "should be less than 5MB")
    end
  end
end