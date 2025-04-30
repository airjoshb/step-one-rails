class Survey < ApplicationRecord
  has_many :questions
  has_many :survey_responses
  belongs_to :artifact, optional: true
  has_many :question_answers, through: :survey_responses
  has_many :answer_options, through: :questions
  accepts_nested_attributes_for :survey_responses
  accepts_nested_attributes_for :questions

  has_many_attached :trix_attachments
  
  has_rich_text :description
  
end
