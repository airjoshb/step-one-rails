class SurveyResponsesController < ApplicationController
  before_action :set_survey!
  before_action :set_survey_response, only: %i[ edit update destroy ]

  def show
    @survey = Survey.includes(questions: :answer_options).find(params[:survey_id])
    @survey_response = @survey.survey_responses.find(params[:id])
  end

  def new
    @survey = Survey.find(params[:survey_id])
    @response = SurveyResponseBuilder.new(survey_response_params)
    @response.build_customer
  end

  def create
    @customer = find_or_initialize_customer
    @survey_response_builder = SurveyResponseBuilder.new(survey_response_params)

      if @survey_response_builder.save
        return redirect_to [@survey, @response], notice: "Survey response was successfully created."
      else
        render :new
      end
  end



  private

  def set_survey!
    @survey = Survey.find(params[:survey_id])
  end

  def set_survey_response
    @survey_response = @survey.survey_responses.find(params[:id])
  end

  def find_or_initialize_customer
    customer_params = survey_response_params.delete(:customer_attributes)
    customer = Customer.find_or_initialize_by(email: customer_params[:email])
    customer.assign_attributes(customer_params)
    customer
  end

  def survey_response_params
    @survey
  end
end
