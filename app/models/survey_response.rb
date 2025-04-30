class SurveyResponse < ApplicationRecord
  belongs_to :survey
  belongs_to :customer
  has_many :question_answers, dependent: :destroy

  accepts_nested_attributes_for :customer
  accepts_nested_attributes_for :question_answers

  def answered_questions_with_responses
    question_answers.includes(:question).map do |qa|
      {
        question: qa.question.question_text,
        answer: qa.answer_response.present? ? qa.answer_response : qa.answer_option_ids.map { |id| qa.question.answer_options.find(id).answer_text }
      }
    end
  end
end
