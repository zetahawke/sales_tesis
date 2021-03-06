module Admin
  class SatisfactionQuestionariesController < AdminController
    before_action :set_satisfaction_questionary, only: [:show, :edit, :update, :destroy]
    before_action :set_form_url, only: [:edit, :new]
  
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
  
    # GET /satisfaction_questionaries/new
    def new_massive
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
          format.html { redirect_to admin_satisfaction_questionary_path(@satisfaction_questionary), notice: 'Satisfaction questionary was successfully created.' }
          format.json { render :show, status: :created, location: @satisfaction_questionary }
        else
          format.html { render :new }
          format.json { render json: @satisfaction_questionary.errors, status: :unprocessable_entity }
        end
      end
    end

    def create_massive
      @satisfaction_questionaries = SatisfactionQuestionary.save_massive(satisfaction_questionary_params, salesmen_params)
      respond_to do |format|
        if @satisfaction_questionaries
          format.html { redirect_to admin_satisfaction_questionaries_path, notice: 'Satisfaction questionaries was successfully created.' }
          format.json { render json: { status: :created, location: @satisfaction_questionaries } }
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
          format.html { redirect_to admin_satisfaction_questionary_path(@satisfaction_questionary), notice: 'Satisfaction questionary was successfully updated.' }
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
        format.html { redirect_to admin_satisfaction_questionaries_url, notice: 'Satisfaction questionary was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_satisfaction_questionary
        @satisfaction_questionary = SatisfactionQuestionary.find(params[:id])
      end
  
      def set_form_url
        @url = params[:action] == 'edit' ? admin_satisfaction_questionary_path(@satisfaction_questionary) : admin_satisfaction_questionaries_path
      end
  
      # Only allow a list of trusted parameters through.
      def satisfaction_questionary_params
        params.require(:satisfaction_questionary).permit(:visit_id, questions: [])
      end

      def salesmen_params
        params.require(:satisfaction_questionary).permit(salesmen: [])
      end
  end
end
