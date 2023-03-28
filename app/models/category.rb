class Category < ApplicationRecord
  has_many :products
  has_many :posts
  has_one_attached :image, dependent: :destroy
  has_many :children, class_name: "Category", foreign_key: 'parent_id'
  belongs_to :parent, class_name: "Category", foreign_key: 'parent_id', optional: true
  
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  before_validation :should_generate_new_friendly_id?

  default_scope { order(:row_order) }
  scope :no_children, -> {left_joins(:parent).where( parent: {id: nil} )}

  def has_children?
    self.children.present?
  end

  def siblings
    parent.children.where.not(id:self.id)
  end

  def subcategories
    parent.children
  end

  def should_generate_new_friendly_id?
    name_changed?
  end

end
