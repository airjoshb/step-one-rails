class SurveyResponse < ApplicationRecord
  belongs_to :survey
  belongs_to :customer
  has_many :question_answers

  accepts_nested_attributes_for :customer
  accepts_nested_attributes_for :question_answers
end
