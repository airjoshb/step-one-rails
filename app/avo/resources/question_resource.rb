class QuestionResource < Avo::BaseResource
  self.title = :id
  self.includes = []
  # self.search_query = -> do
  #   scope.ransack(id_eq: params[:q], m: "or").result(distinct: false)
  # end

  field :id, as: :id
  # Fields generated from the model
  field :question_text, as: :textarea
  field :question_type, as: :select, enum: Question.question_types
  field :survey, as: :belongs_to
  field :answer_options, as: :has_many
  # add fields here
end
