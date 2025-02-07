class CreateQuestions < ActiveRecord::Migration[7.0]
  def up
    create_enum :question_type, [ :open_question, :choose_one, :multiple_select ]


    create_table :questions do |t|
      t.enum :question_type, enum_type: "question_type", default: :choose_one
      t.text :question_text
      t.belongs_to :survey, null: false, foreign_key: true
      t.timestamps
    end
  end

  def down
    drop_table :questions

    execute <<-SQL
      DROP TYPE question_type;
    SQL
  end

end
