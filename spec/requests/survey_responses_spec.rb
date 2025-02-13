require 'rails_helper'

RSpec.describe "SurveyResponses", type: :request do
  let(:survey) { create(:survey) }
  let(:customer) { create(:customer) }
  let(:question) { create(:question, survey: survey, question_type: 'choose_one') }
  let!(:answer_option) { create(:answer_option, question: question) }
  let(:valid_attributes) {
    {
      survey_response: {
        survey_id: survey.id,
        customer_attributes: {
          name: customer.name,
          email: customer.email
        },
        question_answers_attributes: {
          question_id: question.id,
          answer_option_ids: [answer_option.id]
        }
      }
    }
  }

  describe "POST /survey_responses" do
    it "creates a new SurveyResponse" do
      expect {
        post survey_survey_responses_path(survey), params: valid_attributes
      }.to change(SurveyResponse, :count).by(1)
    end

    it "redirects to the created survey_response" do
      post survey_survey_responses_path(survey), params: valid_attributes
      expect(response).to redirect_to(survey_survey_response_path(survey, SurveyResponse.last))
    end

    it "creates associated QuestionAnswer with correct answer_option_ids" do
      post survey_survey_responses_path(survey), params: valid_attributes
      question_answer = SurveyResponse.last.question_answers.first
      expect(question_answer.answer_option_ids).to eq([answer_option.id])
    end
  end
end