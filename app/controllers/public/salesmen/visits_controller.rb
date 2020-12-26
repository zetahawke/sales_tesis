module Public
  module Salesmen
    class VisitsController < Public::TokenizedController
      before_action :set_visit, only: [:show, :edit, :update, :destroy]
      before_action :set_form_url, only: [:edit, :new]
      before_action :validate_excuse, only: [:update]
    
      # GET /visits
      # GET /visits.json
      def index
        @visits = current_entity.visits.order(id: :desc)
      end
    
      # GET /visits/1/edit
      def edit
        if @visit.excuse && @visit.status != 'created'
          redirect_to public_salesmen_visits_path(token: params[:token]), alert: 'Ya has excusado dicha visita o ya no se puede modificar.'
        else
          @visit.build_excuse
        end
      end
    
      # PATCH/PUT /visits/1
      # PATCH/PUT /visits/1.json
      def update
        respond_to do |format|
          if @visit.update(to_update_params)
            format.html { redirect_to public_salesmen_visits_path(token: params[:token]), notice: 'Visit was successfully updated.' }
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
        @url = params[:action] == 'edit' ? public_salesmen_visit_path(@visit, token: params[:token]) : public_salesmen_visits_path(token: params[:token])
      end
  
      # Only allow a list of trusted parameters through.
      def visit_params
        params.require(:visit).permit(:sale_amount, excuse_attributes: [:reason], appointment_attributes: [:realized_at])
      end

      def validate_excuse
        if visit_params[:excuse_attributes][:reason].blank?
          if visit_params[:appointment_attributes][:realized_at].blank? || visit_params[:sale_amount].blank?
            redirect_to edit_public_salesmen_visit_path(@visit, token: params[:token]), alert: 'En caso de no excusar la visita, debes rellenar el monto de la venta y la fecha de la visita realizada.'
          end
        end
      end

      def to_update_params
        if visit_params[:excuse_attributes][:reason].blank?
          params.require(:visit).permit(:sale_amount, appointment_attributes: [:realized_at])
        else
          params.require(:visit).permit(excuse_attributes: [:reason])
        end
      end
    end
  end
end
