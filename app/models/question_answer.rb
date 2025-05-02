class QuestionAnswer < ApplicationRecord
  belongs_to :question
  belongs_to :survey_response, inverse_of: :question_answers
  has_one :survey, through: :survey_response
  validates :question, :survey_response, presence: true


end
