module Public
  module Customers
    class VisitsController < Public::TokenizedController
      before_action :set_visit, only: [:show, :edit, :update, :destroy]
      before_action :set_form_url, only: [:edit, :new]
    
      # GET /visits
      # GET /visits.json
      def index
        @visits = current_entity.visits.order(id: :desc)
      end
    
      # GET /visits/1/edit
      def edit
      end
    
      # PATCH/PUT /visits/1
      # PATCH/PUT /visits/1.json
      def update
        respond_to do |format|
          if @visit.update(visit_params)
            format.html { redirect_to public_customers_visits_path(token: params[:token]), notice: 'Visit was successfully updated.' }
            format.json { render :index, status: :ok }
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
        @url = params[:action] == 'edit' ? public_customers_visit_path(@visit, token: params[:token]) : public_customers_visits_path(token: params[:token])
      end
  
      # Only allow a list of trusted parameters through.
      def visit_params
        params.require(:visit).permit(:status)
      end
    end
  end
end
