class SpidRails::SingleLogoutOperationsController < SpidRails::SpidController
  skip_before_action :verify_authenticity_token, only: :create

  def new
    logout_request = SpidRails::SloRequest.new(slo_params)
    redirect_to logout_request.to_saml
    session[:spid_slo_id] = logout_request.uuid
  end

  def create
    logout_response = OneLogin::RubySaml::Logoutresponse.new(params[:SAMLResponse],
                                                             slo_settings,
                                                             matches_request_id: session[:spid_slo_id])
    if logout_response.validate
      session[:sso_params] = nil
      session[:spid_index] = nil
      session[:spid_slo_id] = nil
      redirect_to main_app.welcome_path, notice: 'Utente correttamente sloggato'
    else
      render plain: response.inspect
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
