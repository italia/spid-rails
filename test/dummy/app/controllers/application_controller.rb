class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def validate_spid_session
    if session[:spid_index].blank?
      session[:spid_relay_state] = request.path
      redirect_to welcome_path
    end
  end

end
