module Admin
  class AcceptanceCriteriaController < ApplicationController
    before_action :set_acceptance_criterium, only: [:show, :edit, :update, :destroy]
  
    # GET /acceptance_criteria
    # GET /acceptance_criteria.json
    def index
      @acceptance_criteria = AcceptanceCriterium.all
    end
  
    # GET /acceptance_criteria/1
    # GET /acceptance_criteria/1.json
    def show
    end
  
    # GET /acceptance_criteria/new
    def new
      @acceptance_criterium = AcceptanceCriterium.new
    end
  
    # GET /acceptance_criteria/1/edit
    def edit
    end
  
    # POST /acceptance_criteria
    # POST /acceptance_criteria.json
    def create
      @acceptance_criterium = AcceptanceCriterium.new(acceptance_criterium_params)
  
      respond_to do |format|
        if @acceptance_criterium.save
          format.html { redirect_to @acceptance_criterium, notice: 'Acceptance criterium was successfully created.' }
          format.json { render :show, status: :created, location: @acceptance_criterium }
        else
          format.html { render :new }
          format.json { render json: @acceptance_criterium.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /acceptance_criteria/1
    # PATCH/PUT /acceptance_criteria/1.json
    def update
      respond_to do |format|
        if @acceptance_criterium.update(acceptance_criterium_params)
          format.html { redirect_to @acceptance_criterium, notice: 'Acceptance criterium was successfully updated.' }
          format.json { render :show, status: :ok, location: @acceptance_criterium }
        else
          format.html { render :edit }
          format.json { render json: @acceptance_criterium.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /acceptance_criteria/1
    # DELETE /acceptance_criteria/1.json
    def destroy
      @acceptance_criterium.destroy
      respond_to do |format|
        format.html { redirect_to acceptance_criteria_url, notice: 'Acceptance criterium was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_acceptance_criterium
        @acceptance_criterium = AcceptanceCriterium.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def acceptance_criterium_params
        params.require(:acceptance_criterium).permit(:name, :criteria, :criteria_value)
      end
  end
end
