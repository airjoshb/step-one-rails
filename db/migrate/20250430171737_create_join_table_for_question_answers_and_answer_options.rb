class CreateJoinTableForQuestionAnswersAndAnswerOptions < ActiveRecord::Migration[7.0]
  def change
    create_join_table :question_answers, :answer_options do |t|
      # t.index [:question_answer_id, :answer_option_id]
      # t.index [:answer_option_id, :question_answer_id]
    end
  end
end
