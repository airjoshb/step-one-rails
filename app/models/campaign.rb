class Campaign < ApplicationRecord
  has_and_belongs_to_many :emails
  has_and_belongs_to_many :customers

  def send_email
    self.emails.each do |email|
      expected_ids = self.customers.pluck(:id)
      sent_customer_ids = email.customer_emails.pluck(:customer_id)
      next email if sent_customer_ids.sort == expected_ids.sort
      email.generate_customer_emails(self)
    end
  end

end
