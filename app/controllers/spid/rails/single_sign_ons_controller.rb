class Spid::Rails::SingleSignOnsController < Spid::Rails::SpidController
  skip_before_action :verify_authenticity_token, only: :create

  def new
    request = Spid::Rails::Request.new(sso_params)
    redirect_to request.to_saml
  end

  def create
    response = OneLogin::RubySaml::Response.new(params[:SAMLResponse])
    response.settings = sso_settings_old
    if response.is_valid?
      session[:index] = response.sessionindex
      redirect_to main_app.welcome_path, notice: 'Utente correttamente loggato'
    else
      render plain: response.inspect
    end
  end

  private

  def sso_params
    sso_params = params.require(:sso).permit(:idp, :spid_level, bindings: [])
    sso_params[:host] = main_app.root_url
    sso_params
  end

end
