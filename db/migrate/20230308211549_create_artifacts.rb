class CreateArtifacts < ActiveRecord::Migration[7.0]
  def change
    create_table :artifacts do |t|
      t.string :name
      t.string :url
      t.string :image
      t.references :category, foreign_key: true
      t.string :slug

      t.timestamps
    end
  end
end
