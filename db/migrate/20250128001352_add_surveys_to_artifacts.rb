class AddSurveysToArtifacts < ActiveRecord::Migration[7.0]
  def change
    add_reference :artifacts, :survey, null: true, foreign_key: true
  end
end
