module Public
  class TokenizedController < ApplicationController
    include Authenticable
    before_action :verify_authenticity

    private

    def verify_authenticity
      redirect_to root_path, alert: 'No tienes acceso a este módulo' if current_entity.blank?
    end
  end
end