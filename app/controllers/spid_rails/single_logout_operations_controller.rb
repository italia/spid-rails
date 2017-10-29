class SpidRails::SingleLogoutOperationsController < SpidRails::SpidController
  skip_before_action :verify_authenticity_token, only: :create

  def new
    logout_request = SpidRails::SloRequest.new(slo_params)
    redirect_to logout_request.to_saml
    session[:transaction_id] = logout_request.uuid
  end

  def create
    logout_response = OneLogin::RubySaml::Logoutresponse.new(params[:SAMLResponse],
                                                             slo_settings,
                                                             matches_request_id: session[:transaction_id])
    if logout_response.validate
      session[:spid_index] = nil
      redirect_to main_app.welcome_path, notice: 'Utente correttamente sloggato'
    else
      render plain: response.inspect
    end
  end

  private

  def slo_params
    session[:sso_params].merge(session_index: session[:index])
  end

end
