class AddPubDateToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :pub_date, :datetime
  end
end
