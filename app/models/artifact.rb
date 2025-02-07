class Artifact < ApplicationRecord
  belongs_to :category, optional: true
  has_and_belongs_to_many :posts
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  has_one :survey
  has_rich_text :description
  has_one_attached :image, dependent: :destroy
  has_one_attached :markdown, dependent: :destroy
  has_many_attached :trix_attachments

  scope :embeds, -> {where.not( embed: [nil, ""])}
  scope :not_embeds, -> {where( embed: [nil, ""])}
  scope :upcoming, -> {where( 'artifact_date >= ?', Date.today )}

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

  def convert_markdown
    require 'open-uri'
    return unless self.markdown.attached?
    self.markdown.blob.open do |file|
      File.foreach(file) do |line|
        if line.include?('image:')
          image = line.gsub("image: ","")
          image = image.gsub(/\\$/, "")
          image = image.squish
          uri = Cloudinary::Utils.cloudinary_url(image)
          file = URI.open(uri)
          self.image.attach(io: file, filename: image)
        elsif line.include?('link:')
          link = line.gsub("link: ","")
          link = link.squish
          self.url = link
        elsif line.include?('---')          
        else
          body = ActionText::Content.new(self.markdown).to_trix_html
          ActionText::RichText.create!(record_type: 'Artifact', record_id: self.id, name: 'description', body: body )
        end
      end
      self.save
    end
  end
end
