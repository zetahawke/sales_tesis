class SatisfactionQuestionariesController < ApplicationController
  before_action :set_satisfaction_questionary, only: [:show, :edit, :update, :destroy]

  # GET /satisfaction_questionaries
  # GET /satisfaction_questionaries.json
  def index
    @satisfaction_questionaries = SatisfactionQuestionary.all
  end

  # GET /satisfaction_questionaries/1
  # GET /satisfaction_questionaries/1.json
  def show
  end

  # GET /satisfaction_questionaries/new
  def new
    @satisfaction_questionary = SatisfactionQuestionary.new
  end

  # GET /satisfaction_questionaries/1/edit
  def edit
  end

  # POST /satisfaction_questionaries
  # POST /satisfaction_questionaries.json
  def create
    @satisfaction_questionary = SatisfactionQuestionary.new(satisfaction_questionary_params)

    respond_to do |format|
      if @satisfaction_questionary.save
        format.html { redirect_to @satisfaction_questionary, notice: 'Satisfaction questionary was successfully created.' }
        format.json { render :show, status: :created, location: @satisfaction_questionary }
      else
        format.html { render :new }
        format.json { render json: @satisfaction_questionary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /satisfaction_questionaries/1
  # PATCH/PUT /satisfaction_questionaries/1.json
  def update
    respond_to do |format|
      if @satisfaction_questionary.update(satisfaction_questionary_params)
        format.html { redirect_to @satisfaction_questionary, notice: 'Satisfaction questionary was successfully updated.' }
        format.json { render :show, status: :ok, location: @satisfaction_questionary }
      else
        format.html { render :edit }
        format.json { render json: @satisfaction_questionary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /satisfaction_questionaries/1
  # DELETE /satisfaction_questionaries/1.json
  def destroy
    @satisfaction_questionary.destroy
    respond_to do |format|
      format.html { redirect_to satisfaction_questionaries_url, notice: 'Satisfaction questionary was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_satisfaction_questionary
      @satisfaction_questionary = SatisfactionQuestionary.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def satisfaction_questionary_params
      params.require(:satisfaction_questionary).permit(:visit_id, :questions)
    end
end
