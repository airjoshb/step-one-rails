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

  # before_save :convert_attachment, if: Proc.new { markdown_changed? }
  # after_save :convert_html, if: Proc.new { html_text_changed? }
  before_validation :should_generate_new_friendly_id?

  default_scope  { order(created_at: :desc) }
  scope :no_children, -> {left_joins(:children).where( children: {id: nil} )}
  scope :only_parents, -> {left_joins(:parent).where( parent: {id: nil} )}
  scope :updates, -> {left_joins(:category).where( category: {name: 'Updates'} )}
  scope :not_updates, -> {left_joins(:category).where.not( category: {name: 'Updates'} )}

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
    name_changed?
  end

  def shortened_content(length)
    self.content.to_plain_text.truncate(length)
  end

  def convert_html
    return unless self.html_text.present?
    body = ActionText::Content.new(self.html_text).to_trix_html
    ActionText::RichText.create!(record_type: 'Post', record_id: self.id, name: 'content', body:  body )
  end

  def convert_attachment
    require 'open-uri'
    return unless self.markdown.attached?
    self.markdown.blob.open do |file|
      File.foreach(file) do |line|
        if line.include?('date:')
          date = line.gsub("date: ","")
          self.created_at = date
        elsif line.include?('image:')
          image = line.gsub("image: ","")
          image = image.gsub(/\\$/, "")
          image = image.squish
          uri = Cloudinary::Utils.cloudinary_url(image)
          file = URI.open(uri)
          self.image.attach(io: file, filename: image)
          self.save
        elsif line.include?('categories:')
          category = line.gsub("categories: ","")
          category = category.gsub("[","")
          category = category.gsub("‘","")
          category = category.gsub("]","")
          category = category.gsub("’","")
          category = category.split(",")
          category = Category.first_or_create(slug: category.first.downcase)
          self.category = category
        end
      end
      self.save
    end
  end


end
