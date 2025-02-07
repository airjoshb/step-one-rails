class CreateQuestionAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :question_answers do |t|
      t.belongs_to :question, null: false, foreign_key: true
      t.text :answer_option_ids
      t.text :answer_response
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
