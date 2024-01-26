class CreateCampaignsCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :campaigns_customers, id: false do |t|
      t.belongs_to :campaign, null: false
      t.belongs_to :customer, null: false

      t.timestamps
    end
  end
end
