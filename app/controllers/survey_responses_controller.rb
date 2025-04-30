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
    @survey.questions.each do |question|
      @response.question_answers.build(question_id: question.id)
    end
  end

  def create
    ActiveRecord::Base.transaction do
      customer = find_or_initialize_customer
      raise ActiveRecord::Rollback unless customer.save

      @response = @survey.survey_responses.new(survey_response_params)
      @response.customer = customer
      raise ActiveRecord::Rollback unless @response.save

      redirect_to [@survey, @response], notice: "Survey response was successfully created."
    rescue ActiveRecord::RecordInvalid => e
      flash[:alert] = e.message
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

  def find_or_initialize_customer
    customer_params = survey_response_params.delete(:customer_attributes)
    customer = Customer.find_or_initialize_by(email: customer_params[:email])
    customer.assign_attributes(customer_params)
    customer
  end

  def survey_response_params
    params.require(:survey_response).permit(
      :survey_id, :customer_id,
      customer_attributes: [:name, :email, :id],
      question_answers_attributes: [:question_id, :answer_option_ids, :answer_response]
    )
  end
end
