class SurveyResponsesController < ApplicationController
  before_action :set_survey, except: :show
  before_action :set_survey_response, only: %i[ edit update destroy ]

  def show
    @survey = Survey.includes(questions: :answer_options).find(params[:survey_id])
    @survey_response = @survey.survey_responses.find(params[:id])
  end

  def new
    @response = @survey.survey_responses.new; @response.question_answers.build;
  end

  def create
    @survey_response = @survey.survey_responses.new(survey_response_params)
    if @survey_response.save
      redirect_to [@survey, @survey_response], notice: "survey response was successfully created."
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
    params.require(:survey_response).permit(:survey_id, question_answers: {})
  end
end
