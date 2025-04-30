class QuestionAnswer < ApplicationRecord
  belongs_to :question
  belongs_to :survey_response, inverse_of: :question_answers
  has_one :survey, through: :survey_response
  validates :question, :survey_response, presence: true

  # Ensure answer_option_ids is always an array
  def answer_option_ids=(value)
    super(Array(value).reject(&:blank?)) # Wrap single value in array and reject blanks
  end


end
