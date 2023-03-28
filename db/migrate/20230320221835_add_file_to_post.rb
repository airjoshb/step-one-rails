class AddFileToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :markdown, :string
  end
end
