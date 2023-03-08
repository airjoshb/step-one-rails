class Artifact < ApplicationRecord
  belongs_to :category

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  has_rich_text :description

end
