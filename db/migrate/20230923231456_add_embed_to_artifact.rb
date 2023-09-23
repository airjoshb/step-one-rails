class AddEmbedToArtifact < ActiveRecord::Migration[7.0]
  def change
    add_column :artifacts, :embed, :string
  end
end
