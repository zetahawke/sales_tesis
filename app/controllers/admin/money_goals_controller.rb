module Admin
  class MoneyGoalsController < ApplicationController
    before_action :set_money_goal, only: [:show, :edit, :update, :destroy]
    before_action :set_form_url, only: [:edit, :new]
  
    # GET /money_goals
    # GET /money_goals.json
    def index
      @money_goals = MoneyGoal.all
    end
  
    # GET /money_goals/1
    # GET /money_goals/1.json
    def show
    end
  
    # GET /money_goals/new
    def new
      @money_goal = MoneyGoal.new
    end
  
    # GET /money_goals/1/edit
    def edit
    end
  
    # POST /money_goals
    # POST /money_goals.json
    def create
      @money_goal = MoneyGoal.new(money_goal_params)
  
      respond_to do |format|
        if @money_goal.save
          format.html { redirect_to admin_money_goal_path(@money_goal), notice: 'Money goal was successfully created.' }
          format.json { render :show, status: :created, location: @money_goal }
        else
          format.html { render :new }
          format.json { render json: @money_goal.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /money_goals/1
    # PATCH/PUT /money_goals/1.json
    def update
      respond_to do |format|
        if @money_goal.update(money_goal_params)
          format.html { redirect_to admin_money_goal_path(@money_goal), notice: 'Money goal was successfully updated.' }
          format.json { render :show, status: :ok, location: @money_goal }
        else
          format.html { render :edit }
          format.json { render json: @money_goal.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /money_goals/1
    # DELETE /money_goals/1.json
    def destroy
      @money_goal.destroy
      respond_to do |format|
        format.html { redirect_to admin_money_goals_url, notice: 'Money goal was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_money_goal
        @money_goal = MoneyGoal.find(params[:id])
      end

      def set_form_url
        @url = params[:action] == 'edit' ? admin_money_goal_path(@money_goal) : admin_money_goals_path
      end

      # Only allow a list of trusted parameters through.
      def money_goal_params
        params.require(:money_goal).permit(:amount, :salesman_id, :type_of_criteria)
      end
  end
end
