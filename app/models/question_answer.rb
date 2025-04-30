class QuestionAnswer < ApplicationRecord
  belongs_to :question
  belongs_to :survey_response, dependent: :destroy
  has_and_belongs_to_many :answer_options
  has_one :survey, through: :survey_response
  validates_presence_of :question_id, :survey_response_id


end
