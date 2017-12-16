require_dependency "spid-rails/application_controller"

module Spid
  module Rails

    class SingleLogoutOperationsController < ApplicationController
      skip_before_action :verify_authenticity_token, only: :create

      def new
        logout_request = SpidRails::SloRequest.new(slo_params)
        redirect_to logout_request.to_saml
        session[:spid_slo_id] = logout_request.uuid
      end

      def create
        logout_response = SpidRails::SloResponse.new(params[:SAMLResponse],
                                                    session[:spid_slo_id],
                                                    slo_params)
        # TODO: approfondire validazione logout
        destroy_spid_session
        redirect_to main_app.root_path, notice: 'Logout utente eseguito con successo'
      end

      private

      def slo_params
        {
          host: main_app.root_url,
          idp: session[:sso_params]['idp'],
          session_index: session[:spid_index]
        }
      end

      def destroy_spid_session
        session[:sso_params] = nil
        session[:spid_index] = nil
        session[:spid_slo_id] = nil
        session[:spid_relay_state] = nil
        session[:spid_login_time] = nil
      end

    end

  end
end
