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
          if excuse_sent
            @visit.excuse.update(to_update_params[:excuse_attributes])
          else
            @visit.appointment.update(appointment_params[:appointment_attributes])
          end
          if @visit.update(to_update_params)
            @visit.check_appointment_accomplishment
            format.html { redirect_to public_salesmen_visits_path(token: params[:token]), notice: 'Visit was successfully updated.' }
            format.json { render :index, status: :ok }
          else
            format.html { render :edit }
            format.json { render json: @visit.errors, status: :unprocessable_entity }
          end
        end
      end
  
      private
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

      def excuse_sent
        !visit_params[:excuse_attributes][:reason].blank?
      end

      def valid_parameters
        !excuse_sent && visit_params[:appointment_attributes][:realized_at].blank? || visit_params[:sale_amount].blank?
      end

      def validate_excuse
        redirect_to edit_public_salesmen_visit_path(@visit, token: params[:token]), alert: 'En caso de no excusar la visita, debes rellenar el monto de la venta y la fecha de la visita realizada.' if valid_parameters
      end

      def to_update_params
        if excuse_sent
          params.require(:visit).permit(excuse_attributes: [:reason])
        else
          params.require(:visit).permit(:sale_amount)
        end
      end

      def appointment_params
        params.require(:visit).permit(appointment_attributes: [:realized_at])
      end
    end
  end
end
