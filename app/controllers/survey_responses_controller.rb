class SurveyResponsesController < ApplicationController
  before_action :set_survey, except: :show
  before_action :set_survey_response, only: %i[ edit update destroy ]

  def show
    @survey = Survey.includes(questions: :answer_options).find(params[:survey_id])
    @survey_response = @survey.survey_responses.find(params[:id])
  end

  def new
    @response = SurveyResponse.new
    @response.build_customer
    @survey.questions.each do |question|
      @response.question_answers.build(question: question)
    end
  end

  def create
    customer = find_or_initialize_customer
    if customer.save
      @survey_response = SurveyResponse.new(survey_response_params)
      @question_answers = @survey.questions.collect do |question|
        @survey_response.question_answers.build(question: question)
      end
      @survey_response.customer = customer
      @survey_response.survey = @survey

      if @survey_response.save
        render :new, notice: "Survey response was successfully created."
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

  def find_or_initialize_customer
    customer_params = survey_response_params.delete(:customer_attributes)
    customer = Customer.find_or_initialize_by(email: customer_params[:email])
    customer.assign_attributes(customer_params)
    customer
  end

  def process_question_answers(question_id, option_ids)
    question = Question.find(question_id)
    type = question.question_type
    option_ids = question_answer.answer_option_ids
    # in case of checkboxes, values are submitted as an array of
    # strings. we will store answers as one big string separated
    # by delimiter.
    option_ids = if type == "mutiple_select"
        option_ids.reject(&:blank?).reject { |t| t == "0" }.join(',')
      else
        option_ids
      end
  end

  def survey_response_params
    params.require(:survey_response).permit(
      :survey_id, :customer_id,
      customer_attributes: [:name, :email, :id],
      question_answers_attributes: [:question_id, :answer_option_ids, :answer_response]
    )
  end
end