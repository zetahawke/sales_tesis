module Public
  class AnswersController < ApplicationController
    before_action :set_answer, only: [:update]
    before_action :set_answer_step, only: [:create, :update]
    # POST /answers
    # POST /answers.json
    def create
      @answer = Answer.new(answer_params)
  
      respond_to do |format|
        if @answer.save
          format.html { redirect_to public_sq_path(public_token: @answer.satisfaction_questionary.public_token, step: @step + 1), notice: 'Answer was successfully created.' }
          format.json { render :show, status: :created, location: @answer }
        else
          format.html { redirect_to public_sq_path(public_token: @answer.satisfaction_questionary.public_token, step: @step), alert: 'Answer wasnt saved.' }
          format.json { render json: @answer.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /answers/1
    # PATCH/PUT /answers/1.json
    def update
      respond_to do |format|
        if @answer.update(answer_params)
          format.html { redirect_to public_sq_path(public_token: @answer.satisfaction_questionary.public_token, step: @step + 1), notice: 'Answer was successfully created.' }
          format.json { render :show, status: :ok, location: @answer }
        else
          format.html { redirect_to public_sq_path(public_token: @answer.satisfaction_questionary.public_token, step: @step), alert: 'Answer wasnt saved.' }
          format.json { render json: @answer.errors, status: :unprocessable_entity }
        end
      end
    end

    private
    def set_answer
      @answer = Answer.find(params[:id])
    end
    
    def answer_params
      params.require(:answer).permit(:question_id, :satisfaction_questionary_id, :acceptance_criterium_id, :customer_id)
    end

    def set_answer_step
      @step = params[:step].try(:to_i)
    end
  end
end