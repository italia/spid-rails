require_dependency "spid_rails/application_controller"

module SpidRails

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
      if logout_response.valid?
        session[:sso_params] = session[:spid_index] = session[:spid_slo_id] = nil
        redirect_to main_app.root_path, notice: 'Logout utente eseguito con successo'
      else
        redirect_to main_app.root_path, notice: 'Logout utente fallito'
      end
    end

    private

    def slo_params
      {
        host: main_app.root_url,
        idp: session[:sso_params]['idp'],
        session_index: session[:spid_index]
      }
    end

  end

end
