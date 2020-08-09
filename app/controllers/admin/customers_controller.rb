module Admin
  class CustomersController < AdminController
    before_action :set_customer, only: [:show, :edit, :update, :destroy, :create_token]
    before_action :set_form_url, only: [:edit, :new]
  
    # GET /customers
    # GET /customers.json
    def index
      @customers = Customer.all
    end
  
    # GET /customers/1
    # GET /customers/1.json
    def show
    end
  
    # GET /customers/new
    def new
      @customer = Customer.new
    end
  
    # GET /customers/1/edit
    def edit
    end
  
    # POST /customers
    # POST /customers.json
    def create
      @customer = Customer.new(customer_params)
  
      respond_to do |format|
        if @customer.save
          format.html { redirect_to admin_customer_path(@customer), notice: 'Customer was successfully created.' }
          format.json { render :show, status: :created, location: @customer }
        else
          format.html { render :new }
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /customers/1
    # PATCH/PUT /customers/1.json
    def update
      respond_to do |format|
        if @customer.update(customer_params)
          format.html { redirect_to admin_customer_path(@customer), notice: 'Customer was successfully updated.' }
          format.json { render :show, status: :ok, location: @customer }
        else
          format.html { render :edit }
          format.json { render json: @customer.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /customers/1
    # DELETE /customers/1.json
    def destroy
      @customer.destroy
      respond_to do |format|
        format.html { redirect_to admin_customers_url, notice: 'Customer was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    def create_token
      @customer.generate_private_token
      redirect_to admin_customer_path(@customer), notice: 'Token de acceso creado satisfactoriamente.'
    rescue => _e
      redirect_to admin_customer_path(@customer), alert: 'Error al crear el Token de acceso.'
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_customer
        @customer = Customer.find(params[:id] || params[:customer_id])
      end

      def set_form_url
        @url = params[:action] == 'edit' ? admin_customer_path(@customer) : admin_customers_path
      end
  
      # Only allow a list of trusted parameters through.
      def customer_params
        params.require(:customer).permit(:name, :dni, :email)
      end
  end
end
