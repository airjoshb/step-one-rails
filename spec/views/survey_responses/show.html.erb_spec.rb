require 'rails_helper'

RSpec.describe "survey_responses/show", type: :view do
  before(:each) do
    assign(:survey_response, SurveyResponse.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
