class QuestionAnswerResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :answer_option_ids, as: :textarea
  field :answer_response, as: :textarea
  field :user_id, as: :text
  field :question, as: :belongs_to
  # add fields here
end
