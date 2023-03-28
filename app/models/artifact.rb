class Artifact < ApplicationRecord
  belongs_to :category, optional: true

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  has_rich_text :description

  has_one_attached :image, dependent: :destroy
  has_many_attached :trix_attachments
end
