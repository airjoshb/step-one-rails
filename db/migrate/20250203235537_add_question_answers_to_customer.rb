class AddQuestionAnswersToCustomer < ActiveRecord::Migration[7.0]
  def change
    add_reference :question_answers, :customer, null: false, foreign_key: true
    remove_reference :question_answers, :user
  end
end
