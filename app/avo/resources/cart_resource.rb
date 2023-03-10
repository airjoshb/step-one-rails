class CartResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :orderables, as: :has_many
  field :variations, as: :has_many, through: :orderables
  field :created_at, as: :date_time
  # add fields here
end
