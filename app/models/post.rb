class Post < ApplicationRecord
  belongs_to :category, optional: true
  has_many :children, class_name: "Post", foreign_key: 'parent_id'
  belongs_to :parent, class_name: "Post", foreign_key: 'parent_id', optional: true
  
  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  has_one_attached :image, dependent: :destroy
  has_one_attached :markdown, dependent: :destroy
  has_many_attached :trix_attachments
  
  has_rich_text :content

  # after_save :convert_text
  before_validation :should_generate_new_friendly_id?

  default_scope  { order(created_at: :desc) }
  scope :no_children, -> {left_joins(:children).where( children: {id: nil} )}

  def has_children?
    self.children.present?
  end

  def all_children
    self.left_joins(:children).where.not( children: {id: nil} )
  end

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

  def should_generate_new_friendly_id?
    title_changed?
  end

  def shortened_content(length)
    self.content.to_plain_text.truncate(length)
  end

  def convert_text
    return unless self.markdown.attached?
    self.markdown.blob.open do |file|
      File.foreach(file) do |line|
        if line.include?('title:')
          self.title = line
        elsif line.include?('date:')
          self.created_at = line
        elsif line.include?('categories:')
          category = Category.find_by_slug(line.first.downcase)
          category = category ||= Category.create(name: line.first)
          self.category = category
        elsif line.include?('image:')
          self.image.blob.create(filename: line)
        end
        self.save
      end
    end
  end

end
