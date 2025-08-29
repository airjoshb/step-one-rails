class Email < ApplicationRecord
  has_and_belongs_to_many :campaigns
  has_many :customer_emails
  has_many :customers, through: :customer_emails
  has_many_attached :trix_attachments
  has_rich_text :body

  def generate_customer_emails(campaign)
    campaign.customers.each do |customer|
      next customer if customer.emails.where(id: self.id).present? && self.customer_emails.where(customer_id: customer.id).first.email_sent?
      CampaignCustomerMailer.customer_email(customer,self).deliver
      self.customer_emails.create(email_sent: true, sent_date: Time.zone.now, customer: customer )
    end
  end

end
