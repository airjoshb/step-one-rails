class AddQuestionAnswerRelationToSurvey < ActiveRecord::Migration[7.0]
  def change
    add_reference :question_answers, :survey, null: false, foreign_key: true
  end
end
