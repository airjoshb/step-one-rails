class CreateJoinTablePostArtifacts < ActiveRecord::Migration[7.0]
  def change
    create_join_table :posts, :artifacts do |t|
      t.index :post_id
      t.index :artifact_id
    end
  end
end
