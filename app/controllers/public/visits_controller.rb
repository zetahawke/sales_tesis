module Public
  class VisitsController < ApplicationController
    before_action :set_private_token
    before_action :verify_user
    before_action :set_visit, only: [:show, :edit, :update, :destroy]
    before_action :set_form_url, only: [:edit, :new]
  
    # GET /visits
    # GET /visits.json
    def index
      @visits = Visit.all
    end
  
    # GET /visits/1/edit
    def edit
    end
  
    # PATCH/PUT /visits/1
    # PATCH/PUT /visits/1.json
    def update
      respond_to do |format|
        if @visit.update(visit_params)
          format.html { redirect_to admin_visit_path(@visit), notice: 'Visit was successfully updated.' }
          format.json { render :show, status: :ok, location: @visit }
        else
          format.html { render :edit }
          format.json { render json: @visit.errors, status: :unprocessable_entity }
        end
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_visit
      @visit = Visit.find(params[:id])
    end

    def set_form_url
      @url = params[:action] == 'edit' ? public_visit_path(@visit) : public_visits_path
    end

    # Only allow a list of trusted parameters through.
    def visit_params
      params.require(:visit).permit(:customer_id, :route_id)
    end

    def set_private_token
      @private_token ||= params[:private_token]
    end

    def verify_user
      @current_user ||= Customer.find_by(private_token: @private_token) || Salesman.find_by(private_token: @private_token)
      redirect_to root_path, notice: 'No tienes acceso a este módulo' if @private_token.blank? || @current_user.blank?
    end
  end
end
