class CategoryResource < Avo::BaseResource
  self.title = :name
  self.includes = []
  self.resolve_query_scope = ->(model_class:) do
    model_class.order(name: :asc)
  end

  self.find_record_method = ->(model_class:, id:, params:) {
    model_class.friendly.find id
  }
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :name, as: :text, sortable: true
  field :image, as: :file
  field :products, as: :has_many
  field :row_order, as: :number
  field :children, as: :has_many
  field :parent, as: :belongs_to
  # add fields here

end
