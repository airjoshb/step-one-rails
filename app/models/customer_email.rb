class CustomerEmail < ApplicationRecord
  belongs_to :email
  belongs_to :customer
  
  scope :sent, -> {where( email_sent: true)}
  scope :not_sent, -> {where( email_sent: false)}

end
