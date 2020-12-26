module Admin
  class VisitsController < AdminController
    before_action :set_visit, only: [:show, :edit, :update, :destroy]
    before_action :set_form_url, only: [:edit, :new]
  
    # GET /visits
    # GET /visits.json
    def index
      @visits = Visit.all
    end
  
    # GET /visits/1
    # GET /visits/1.json
    def show
    end
  
    # GET /visits/new
    def new
      if params[:salesman_id]
        salesman = Salesman.find_by(id: params[:salesman_id])
        prev_amount = salesman ? salesman.visits.last.try(:amount) : 0.0
        @visit = Visit.new(sale_amount: prev_amount || 500_000.0)
      else
        @visit = Visit.new
      end
      @visit.appointment ||= Appointment.new
      @visit.excuse ||= Excuse.new
    end
  
    # GET /visits/1/edit
    def edit
      @visit.appointment ||= Appointment.new
      @visit.excuse ||= Excuse.new
    end
  
    # POST /visits
    # POST /visits.json
    def create
      @visit = Visit.new(visit_params)
      @visit.fill_route_id(params[:salesman_id])
  
      respond_to do |format|
        if @visit.save
          format.html { redirect_to admin_visit_path(@visit), notice: 'Visit was successfully created.' }
          format.json { render :show, status: :created, location: @visit }
        else
          format.html { redirect_to new_admin_visit_path(@visit), alert: @visit.errors.messages.values.join("\n") }
          format.json { render json: @visit.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /visits/1
    # PATCH/PUT /visits/1.json
    def update
      respond_to do |format|
        if @visit.update(visit_params) && @visit.excuse.update(excuse_params) && @visit.appointment.update(appointment_params)
          format.html { redirect_to admin_visit_path(@visit), notice: 'Visit was successfully updated.' }
          format.json { render :show, status: :ok, location: @visit }
        else
          format.html { render :edit }
          format.json { render json: @visit.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /visits/1
    # DELETE /visits/1.json
    def destroy
      @visit.destroy
      respond_to do |format|
        format.html { redirect_to admin_visits_url, notice: 'Visit was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_visit
        @visit = Visit.find(params[:id])
      end

      def set_form_url
        @url = params[:action] == 'edit' ? admin_visit_path(@visit) : admin_visits_path
      end

      # Only allow a list of trusted parameters through.
      def visit_params
        params.require(:visit).permit(:customer_id, :route_id, :sale_amount, :status)
      end

      def excuse_params
        params[:visit].require(:excuse_attributes).permit(:valid_argument)
      end

      def appointment_params
        params[:visit].require(:appointment_attributes).permit(:appointed_at, :realized_at, :start_at, :ends_at, :accomplished)
      end
  end
end
