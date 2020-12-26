module Admin
  class SalesmenController < AdminController
    before_action :set_salesman, only: [:show, :edit, :update, :destroy, :create_token]
    before_action :set_salesmen, only: [:index]
    before_action :set_form_url, only: [:edit, :new]
    before_action :set_filter_params, only: [:index, :show]
    before_action :set_graphic_data, only: [:index, :show]
    before_action :set_traffic_light_color, only: [:show]
  
    # GET /salesmen
    # GET /salesmen.json
    def index; end
  
    # GET /salesmen/1
    # GET /salesmen/1.json
    def show
    end
  
    # GET /salesmen/new
    def new
      @salesman = Salesman.new
    end
  
    # GET /salesmen/1/edit
    def edit
    end
  
    # POST /salesmen
    # POST /salesmen.json
    def create
      @salesman = Salesman.new(salesman_params)
  
      respond_to do |format|
        if @salesman.save
          format.html { redirect_to admin_salesman_path(@salesman), notice: 'Salesman was successfully created.' }
          format.json { render :show, status: :created, location: @salesman }
        else
          format.html { render :new }
          format.json { render json: @salesman.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /salesmen/1
    # PATCH/PUT /salesmen/1.json
    def update
      respond_to do |format|
        if @salesman.update(salesman_params)
          format.html { redirect_to admin_salesman_path(@salesman), notice: 'Salesman was successfully updated.' }
          format.json { render :show, status: :ok, location: @salesman }
        else
          format.html { render :edit }
          format.json { render json: @salesman.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /salesmen/1
    # DELETE /salesmen/1.json
    def destroy
      @salesman.destroy
      respond_to do |format|
        format.html { redirect_to admin_salesmen_url, notice: 'Salesman was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def create_token
      @salesman.generate_private_token
      redirect_to admin_salesman_path(@salesman), notice: 'Token de acceso creado satisfactoriamente.'
    rescue => _e
      redirect_to admin_salesman_path(@salesman), alert: 'Error al crear el Token de acceso.'
    end
  
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_salesman
      @salesman = Salesman.find(params[:id] || params[:salesman_id])
    end

    def set_salesmen
      @salesmen = Salesman.all
    end

    def set_form_url
      @url = params[:action] == 'edit' ? admin_salesman_path(@salesman) : admin_salesmen_path
    end

    # Only allow a list of trusted parameters through.
    def salesman_params
      params.require(:salesman).permit(:name, :email)
    end

    def set_filter_params
      params[:type] ||= 'monthly'
      params[:date] ||= Date.current
    end

    def set_graphic_data
      @graphic_data = params[:action] == 'index' ? @salesmen.all_media_percent(params[:type], params[:date]) : @salesman.show_current_metrics(params[:type], params[:date])
    end

    def set_traffic_light_color
      @traffic_light_color = @salesman.traffic_light_for(params[:type], params[:date], 'goals')
      @sales_traffic_light_color = @salesman.traffic_light_for(params[:type], params[:date], 'money_goals')
    end
  end
end
