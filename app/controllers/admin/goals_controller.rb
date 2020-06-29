module Admin
  class GoalsController < AdminController
    before_action :set_goal, only: [:show, :edit, :update, :destroy]
    before_action :set_form_url, only: [:edit, :new]
  
    # GET /goals
    # GET /goals.json
    def index
      @goals = Goal.all
    end
  
    # GET /goals/1
    # GET /goals/1.json
    def show
    end
  
    # GET /goals/new
    def new
      @goal = Goal.new
    end
  
    # GET /goals/1/edit
    def edit
    end
  
    # POST /goals
    # POST /goals.json
    def create
      @goal = Goal.new(goal_params)
  
      respond_to do |format|
        if @goal.save
          format.html { redirect_to admin_goal_path(@goal), notice: 'Goal was successfully created.' }
          format.json { render :show, status: :created, location: @goal }
        else
          format.html { render :new }
          format.json { render json: @goal.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /goals/1
    # PATCH/PUT /goals/1.json
    def update
      respond_to do |format|
        if @goal.update(goal_params)
          format.html { redirect_to admin_goal_path(@goal), notice: 'Goal was successfully updated.' }
          format.json { render :show, status: :ok, location: @goal }
        else
          format.html { render :edit }
          format.json { render json: @goal.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /goals/1
    # DELETE /goals/1.json
    def destroy
      @goal.destroy
      respond_to do |format|
        format.html { redirect_to admin_goals_url, notice: 'Goal was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_goal
        @goal = Goal.find(params[:id])
      end
  
      def set_form_url
        @url = params[:action] == 'edit' ? admin_goal_path(@goal) : admin_goals_path
      end
  
      # Only allow a list of trusted parameters through.
      def goal_params
        params.require(:goal).permit(:salesman_id, :type, :criteria, :criteria_value)
      end
  end
end
