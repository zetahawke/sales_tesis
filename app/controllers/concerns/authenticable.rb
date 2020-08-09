module Authenticable
  extend ActiveSupport::Concern
  included do
    helper_method :current_entity
  end

  protected

  def current_entity
    @current_entity ||= (params[:controller].include?('salesmen') ? Salesman : Customer).find_by(private_token: authenticable_params[:token]) unless authenticable_params[:token].blank?
  end

  def authenticable_params
    params.permit(:token)
  end
end
