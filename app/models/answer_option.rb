class AnswerOption < ApplicationRecord
  belongs_to :question, dependent: :destroy
  has_and_belongs_to_many :question_answers
  validates :answer_text, presence: true, allow_blank: false
end
