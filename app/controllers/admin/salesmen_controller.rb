module Admin
  class SalesmenController < AdminController
    before_action :set_salesman, only: [:show, :edit, :update, :destroy]
    before_action :set_form_url, only: [:edit, :new]
    before_action :set_filter_params, only: [:index]
  
    # GET /salesmen
    # GET /salesmen.json
    def index
      @salesmen = Salesman.all
    end
  
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
  
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_salesman
      @salesman = Salesman.find(params[:id])
    end

    def set_form_url
      @url = params[:action] == 'edit' ? admin_salesman_path(@salesman) : admin_salesmen_path
    end

    # Only allow a list of trusted parameters through.
    def salesman_params
      params.require(:salesman).permit(:name)
    end

    def set_filter_params
      params[:type] ||= 'monthly'
      params[:date] ||= Date.current
    end
  end
end
