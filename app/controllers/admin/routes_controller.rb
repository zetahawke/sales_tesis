module Admin
  class RoutesController < AdminController
    before_action :set_route, only: [:show, :edit, :update, :destroy]
    before_action :set_form_url, only: [:edit, :new]
    before_action :set_filter_params, only: [:index]
  
    # GET /routes
    # GET /routes.json
    def index
      @routes = Route.data_by(params[:type], params[:date].to_date)
    end
  
    # GET /routes/1
    # GET /routes/1.json
    def show
    end
  
    # GET /routes/new
    def new
      @route = Route.new
    end
  
    # GET /routes/1/edit
    def edit
    end
  
    # POST /routes
    # POST /routes.json
    def create
      @route = Route.new(route_params)
  
      respond_to do |format|
        if @route.save
          format.html { redirect_to admin_route_path(@route), notice: 'Route was successfully created.' }
          format.json { render :show, status: :created, location: @route }
        else
          format.html { redirect_to new_admin_route_path(@route), alert: @route.errors.messages.values.join("\n") }
          format.json { render json: @route.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /routes/1
    # PATCH/PUT /routes/1.json
    def update
      respond_to do |format|
        if @route.update(route_params)
          format.html { redirect_to admin_route_path(@route), notice: 'Route was successfully updated.' }
          format.json { render :show, status: :ok, location: @route }
        else
          format.html { render :edit }
          format.json { render json: @route.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /routes/1
    # DELETE /routes/1.json
    def destroy
      @route.destroy
      respond_to do |format|
        format.html { redirect_to admin_routes_url, notice: 'Route was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_route
        @route = Route.find(params[:id])
      end

      def set_form_url
        @url = params[:action] == 'edit' ? admin_route_path(@route) : admin_routes_path
      end
  
      # Only allow a list of trusted parameters through.
      def route_params
        params.require(:route).permit(:salesman_id)
      end

      def set_filter_params
        params[:type] ||= 'monthly'
        params[:date] ||= Date.current
      end
  end
end
