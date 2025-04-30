class SurveyResponsesController < ApplicationController
  before_action :set_survey, except: :show
  before_action :set_survey_response, only: %i[ edit update destroy ]

  def show
    @survey = Survey.includes(questions: :answer_options).find(params[:survey_id])
    @survey_response = @survey.survey_responses.find(params[:id])
  end

  def new
    Rails.logger.debug "Starting new action"
    
    @response = @survey.survey_responses.new
    @response.build_customer
    @response.question_answers.build
    
    Rails.logger.debug "@response initialized: #{@response.inspect}"
    Rails.logger.debug "@survey initialized: #{@survey.inspect}"
  end

  def create
    Rails.logger.debug "Starting create action"
    
    ActiveRecord::Base.transaction do
      customer = find_or_initialize_customer
      Rails.logger.debug "Customer initialized: #{customer.inspect}"

      if customer.save
        Rails.logger.debug "Customer saved successfully: #{customer.id}"
        
        @response = @survey.survey_responses.new(survey_response_params)
        Rails.logger.debug "Processed params: #{survey_response_params.inspect}"
        @response.customer = customer
        Rails.logger.debug "Survey Response initialized: #{@response.inspect}"

        if @response.save
          Rails.logger.debug "Survey Response saved successfully: #{@response.id}"
          return redirect_to [@survey, @response], notice: "Survey response was successfully created."
        else
          Rails.logger.debug "Survey Response save failed: #{@response.errors.full_messages}"
          render :new, status: :unprocessable_entity
        end
      else
        Rails.logger.debug "Customer save failed: #{customer.errors.full_messages}"
        render :new, status: :unprocessable_entity
      end
    end
  rescue => e
    Rails.logger.error "Error in create action: #{e.message}"
    Rails.logger.error e.backtrace.join("\n")
    render :new, status: :unprocessable_entity
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
    Rails.logger.debug "Raw params: #{params.inspect}"
    params.require(:survey_response).permit(
      :survey_id, :customer_id,
      customer_attributes: [:name, :email, :id],
      question_answers_attributes: [:question_id, { answer_option_ids: [] }, :answer_response]
    )
  end
end
