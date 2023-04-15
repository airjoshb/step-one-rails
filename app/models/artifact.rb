class Artifact < ApplicationRecord
  belongs_to :category, optional: true
  has_and_belongs_to_many :posts
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  has_rich_text :description

  has_one_attached :image, dependent: :destroy
  has_many_attached :trix_attachments

  def thumbnail
    Cloudinary::Utils.cloudinary_url(
      self.image.url,
      width: 150, height: 150, crop: :fill, gravity: 'center')
  end

  def medium_image
    Cloudinary::Utils.cloudinary_url(
      self.image,
      width: 300, height: 300, crop: :fill, gravity: 'center')
  end

  def large_image
    Cloudinary::Utils.cloudinary_url(
      self.image,
      width: 600, height: 600, crop: :scale)
  end
end
