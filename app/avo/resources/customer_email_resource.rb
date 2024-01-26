class CustomerEmailResource < Avo::BaseResource
  self.title = :date_time
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :email, as: :belongs_to
  field :customer, as: :belongs_to
  field :email_sent, as: :boolean
  field :sent_date, as: :date_time
  # add fields here
end
