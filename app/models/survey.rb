class Survey < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :survey_responses, dependent: :destroy
  belongs_to :artifact, optional: true
  has_many :question_answers, through: :survey_responses
  has_many :answer_options, through: :questions
  accepts_nested_attributes_for :survey_responses, allow_destroy: true
  accepts_nested_attributes_for :questions, allow_destroy: true

  has_many_attached :trix_attachments
  
  has_rich_text :description
  
end
