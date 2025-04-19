class AddPubOrderToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :pub_order, :integer
  end
end
