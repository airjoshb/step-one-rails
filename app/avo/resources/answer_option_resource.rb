class AnswerOptionResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :answer_text, as: :text
  field :value, as: :number
  field :question, as: :belongs_to
  # add fields here
end
