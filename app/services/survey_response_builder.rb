class SurveyResponseBuilder < BaseService
    attr_accessor :customer, :survey, :questions, :question_answers, :params, :survey_response_id

    def initialize(params = {})
      super(params)
      build_survey_response(params[:survey_response_id])
    end

    def to_model
      @survey_response
    end

    def save!(options = {})
      params.each do |question_id, answer_options|
        question_answer = @survey_response.question_answers.find { |a| a.question_id.to_s == question_id.to_s }
        next unless question_answer
        question = Question.find(question_id)
        type = question.question_type
        option_ids = question_answer.answer_option_ids
        # in case of checkboxes, values are submitted as an array of
        # strings. we will store answers as one big string separated
        # by delimiter.
        option_ids = if type == "mutiple_select"
            strip_checkbox_answers(option_ids).join(',')
          else
            option_ids
          end

      end

      @survey_response.save!
    end

    def save(options = {})
      save!(options)
    rescue ActiveRecord::ActiveRecordError => e
      errors.add(:base, e.message)
      # repopulate answers here in case of failure as they are not getting updated
      @answers = @survey.questions.collect do |question|
        @survey_response.question_answers.find { |a| a.question_id == question.id }
      end
      false
    end

    private

    def build_survey_response(survey_response_id)
      if survey_response_id.present?
        @survey_response = SurveyResponse.find(survey_response_id)
        self.question_answers = @survey_response.question_answers
        self.customer = @survey_response.customer
        self.survey = @survey_response.survey
        self.questions = @survey.questions
      else
        @survey_response = SurveyResponse.new(customer: customer, survey: survey)
        @question_answers = @survey.questions.collect do |question|
          @survey_response.question_answers.build(question_id: question.id)
        end
      end
    end

    def strip_checkbox_answers(answers)
      answers.reject(&:blank?).reject { |t| t == "0" }
    end
  end