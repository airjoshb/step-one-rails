class AddDateToArtifact < ActiveRecord::Migration[7.0]
  def change
    add_column :artifacts, :artifact_date, :datetime
  end
end
