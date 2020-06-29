module Public
  class SatisfactionQuestionariesController < ApplicationController
    before_action :set_satisfaction_questionary, only: [:by_token]
    before_action :set_step, only: [:by_token]
    before_action :set_question, only: [:by_token]
    before_action :set_answer, only: [:by_token]
    before_action :set_progress_bar, only: [:by_token]
    before_action :set_form_url, only: [:by_token]

    def by_token; end
    
    private

    def set_satisfaction_questionary
      @satisfaction_questionary = SatisfactionQuestionary.find_by(public_token: params[:public_token])
      redirect_to root_path, alert: 'No existe el cuestionario.' unless @satisfaction_questionary
    rescue StandardError => _e
      redirect_to root_path, alert: 'No existe el cuestionario.'
    end

    def set_step
      @step =
        if params[:step]
          params[:step]
        else
          if @satisfaction_questionary.answers.blank?
            0
          else
            last_answer = @satisfaction_questionary.answers.sort.last
            @satisfaction_questionary.questions.index { |question| question == last_answer.question.id }
          end
        end
    end

    def set_question
      @question = Question.find_by(id: @satisfaction_questionary.questions[@step])
    end

    def set_answer
      previous_answer = @satisfaction_questionary.answers.find_by(question_id: @question.id)

      @answer =
        if previous_answer
          previous_answer
        else
          @satisfaction_questionary.answers.new(question_id: @question.id)
        end
    end

    def set_progress_bar
      @total_questions = @satisfaction_questionary.questions.size
      @progression = (100 / @total_questions) * (step + 1)
    end

    def set_form_url
      @url = @answer.id.blank? ? public_answer_index_path : public_answer_path(@answer)
    end
  end
end