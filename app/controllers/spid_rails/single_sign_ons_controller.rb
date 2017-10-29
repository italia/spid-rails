class SpidRails::SingleSignOnsController < SpidRails::SpidController
  skip_before_action :verify_authenticity_token, only: :create

  def new
    request = SpidRails::Request.new(sso_params)
    redirect_to request.to_saml
    session[:sso_params] = sso_params
  end

  def create
    # TODO: redirect a richiesta originale
    response = SpidRails::Response.new(params[:SAMLResponse], session[:sso_params])
    if response.valid?
      session[:index] = response.session_index
      redirect_to main_app.root_path, notice: 'Utente autenticato con successo'
    else
      redirect_to main_app.root_path, notice: 'Autenticazione fallita'
    end
  end

  private

  def sso_params
    sso_params = params.require(:sso).permit(:idp, :spid_level, bindings: [])
    sso_params[:host] = main_app.root_url
    sso_params
  end

end
