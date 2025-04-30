class AnswerOption < ApplicationRecord
  belongs_to :question, dependent: :destroy
  has_many :answer_questions
  has_many :question_answers, through: :answer_questions
  validates :answer_text, presence: true, allow_blank: false

  accepts_nested_attributes_for :answer_questions
end
