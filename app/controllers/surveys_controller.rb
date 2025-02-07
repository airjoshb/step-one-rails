class SurveysController < ApplicationController
  before_action :set_survey, only: [:show]
  
  def show
  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
  end
  
  def survey_params
    params.require(:survey).permit(
      :title,
      survey_response_attributes: {},
      questions_attributes: [
        :_destroy,
        :id,
        :question_type,
        :question_text,
      ]
    )
  end
end