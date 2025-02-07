class CreateAnswerOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :answer_options do |t|
      t.text :answer_text
      t.integer :value
      t.belongs_to :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
