class AddHtmlTextToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :html_text, :string
  end
end
