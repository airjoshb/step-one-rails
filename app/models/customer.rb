class Customer < ApplicationRecord
  has_many :customer_orders
  has_many :addresses, through: :customer_orders
  has_many :payment_methods, through: :customer_orders
  has_many :orderables, through: :customer_orders
  has_and_belongs_to_many :campaigns
  has_many :customer_emails
  has_many :emails, through: :customer_emails
  has_many :survey_responses
  has_many :question_answers, through: :survey_responses
  has_many :questions, through: :question_answers
  validates :email, presence: true
  validates_uniqueness_of :email
  
  has_subscriptions


end
