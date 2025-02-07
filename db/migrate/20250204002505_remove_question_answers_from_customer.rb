class RemoveQuestionAnswersFromCustomer < ActiveRecord::Migration[7.0]
  def change
    add_reference :question_answers, :survey_response, null: false, foreign_key: true
  end
end
