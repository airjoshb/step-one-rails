class QuestionAnswer < ApplicationRecord
  belongs_to :question
  belongs_to :survey_response
  serialize :answer_option_ids, Array
  has_one :survey, through: :survey_response
  validates_presence_of :question_id, :survey_response_id

  def multiple_choice_answers(id)
    return [] if answer_option_ids[id.to_s].nil?
    answer_option_ids[id.to_s].map(&:to_i)
  end
end
