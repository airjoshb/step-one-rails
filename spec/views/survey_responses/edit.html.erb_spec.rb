require 'rails_helper'

RSpec.describe "survey_responses/edit", type: :view do
  let(:survey_response) {
    SurveyResponse.create!()
  }

  before(:each) do
    assign(:survey_response, survey_response)
  end

  it "renders the edit survey_response form" do
    render

    assert_select "form[action=?][method=?]", survey_response_path(survey_response), "post" do
    end
  end
end
