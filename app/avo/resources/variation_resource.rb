class VariationResource < Avo::BaseResource
  self.title = :name
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :product, as: :belongs_to
  field :name, as: :text
  field :amount, as: :number
  field :stripe_id, as: :text
  field :active, as: :boolean
  field :add_on, as: :boolean
  field :count_on_hand, as: :number
  field :unit_quantity, as: :number
  field :row_order, as: :number
  field :recurring, as: :boolean
  field :inventory_type, as: :select, enum: ::Variation.inventory_types
  field :interval, as: :select, enum: ::Variation.intervals, include_blank: 'No Interval'
  field :interval_count, as: :number
  field :orderables, as: :has_many
  field :stripe_id, as: :text, hide_on: [:edit, :index, :new]
  field :carts, as: :has_many, through: :orderables
  # add fields here

  self.resolve_find_scope = ->(model_class:) do
    model_class.friendly
  end
end
