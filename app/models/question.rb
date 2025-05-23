class Question < ApplicationRecord
  belongs_to :survey, inverse_of: :questions
  has_many :answer_options, dependent: :destroy
  has_many :question_answers, dependent: :destroy
  accepts_nested_attributes_for :question_answers
  enum question_type: {open_question: 'open_question', choose_one: 'choose_one', multiple_select: 'multiple_select'}

end
