class Post < ApplicationRecord
  belongs_to :category
  
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  has_one_attached :image, dependent: :destroy
  has_many_attached :trix_attachments
  
  has_rich_text :content

  def thumbnail
    self.image.key(width: 150, height: 150, crop: :fill, gravity: 'center')
  end

  def medium_image
    Cloudinary::Utils.cloudinary_url(
      self.image,
      transformation: [{width: 300, height: 300, crop: :fill, gravity: 'center'}])
  end

  def large_image
    Cloudinary::Utils.cloudinary_url(
      self.image,
      transformation: [{width: 600, height: 600, crop: :scale}])
  end

end
