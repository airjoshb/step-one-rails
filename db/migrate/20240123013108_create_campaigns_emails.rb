class CreateCampaignsEmails < ActiveRecord::Migration[7.0]
  def change
    create_table :campaigns_emails, id: false do |t|
      t.belongs_to :campaign, null: false
      t.belongs_to :email, null: false

      t.timestamps
    end
  end
end
