require_dependency "spid_rails/application_controller"

module SpidRails
  
  class SingleSignOnsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create

    def new
      request = SpidRails::SsoRequest.new(sso_params)
      redirect_to request.to_saml
      session[:sso_params] = sso_params
    end

    def create
      # TODO: redirect a richiesta originale
      response = SpidRails::SsoResponse.new(params[:SAMLResponse], session[:sso_params])
      if response.valid?
        session[:spid_index] = response.session_index
        session[:spid_login_time] = Time.now
        redirect_to session[:spid_relay_state], notice: 'Utente autenticato con successo'
      else
        redirect_to main_app.root_path, notice: 'Autenticazione fallita'
      end
    end

    private

    def sso_params
      sso_params = params.require(:sso).permit(:idp, :spid_level, bindings: [])
      sso_params[:host] = main_app.root_url
      sso_params[:relay_state] = session[:spid_relay_state] || main_app.root_url
      sso_params
    end

  end

end
