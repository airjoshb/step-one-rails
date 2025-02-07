class AnswerOption < ApplicationRecord
  belongs_to :question
  validates :answer_text, presence: true, allow_blank: false
end
