class Email < ApplicationRecord
  has_and_belongs_to_many :campaigns
  has_and_belongs_to_many :customers

  has_rich_text :body

  def generate_customer_emails
    'get all subscribers with boxes
    create emails using customer emails with variation prefs, notes, and add ons'
  end
end
