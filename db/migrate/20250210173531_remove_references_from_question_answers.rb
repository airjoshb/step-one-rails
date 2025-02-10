class RemoveReferencesFromQuestionAnswers < ActiveRecord::Migration[7.0]
  def change
    remove_reference :question_answers, :user
    remove_reference :question_answers, :survey
  end
end
