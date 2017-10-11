class Spid::Rails::SingleLogoutOperationsController < Spid::Rails::SpidController
  skip_before_action :verify_authenticity_token, only: :create

  def new
    logout_request = OneLogin::RubySaml::Logoutrequest.new()
    session[:transaction_id] = logout_request.uuid
    redirect_to logout_request.create(saml_settings)
  end

  def create
    logout_response = OneLogin::RubySaml::Logoutresponse.new(params[:SAMLResponse],
                                                             saml_settings,
                                                             matches_request_id: session[:transaction_id])
    if logout_response.validate
      session[:index] = nil
      redirect_to main_app.welcome_path, notice: 'Utente correttamente sloggato'
    else
      render plain: responde.inspect
    end
  end

end
