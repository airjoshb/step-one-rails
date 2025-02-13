class SurveyResponsesController < ApplicationController
  before_action :set_survey, except: :show
  before_action :set_survey_response, only: %i[ edit update destroy ]

  def show
    @survey = Survey.includes(questions: :answer_options).find(params[:survey_id])
    @survey_response = @survey.survey_responses.find(params[:id])
  end

  def new
    @response = @survey.survey_responses.new
    @response.build_customer
    @response.question_answers.build
  end

  def create
    customer_params = survey_response_params.delete(:customer_attributes)
    customer = Customer.find_or_initialize_by(email: customer_params[:email])
    customer.assign_attributes(customer_params)

    if customer.save
      @response = @survey.survey_responses.new(survey_response_params)
      @response.customer = customer

      if @response.save
        redirect_to [@survey, @survey_response], notice: "Survey response was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def set_survey_response
    @survey_response = @survey.survey_responses.find(params[:id])
  end

  def survey_response_params
    params.require(:survey_response).permit(:survey_id, customer_attributes: [:name, :email], question_answers_attributes: {})
  end
end
