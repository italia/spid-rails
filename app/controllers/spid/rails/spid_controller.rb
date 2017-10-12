class Spid::Rails::SpidController < ApplicationController

  private

  def metadata_settings
    settings = OneLogin::RubySaml::Settings.new sp_attributes
  end

  def sso_settings
    settings = OneLogin::RubySaml::Settings.new sso_attributes
  end

  def slo_settings
    settings = OneLogin::RubySaml::Settings.new slo_attributes
  end

  def sp_attributes
    {
      # Indirizzo del metadata del service provider: /spid/metadata.
      issuer: metadata_url,
      # Indirizzo che l'identity provider chiama una volta che l'utente ha effettuato l'accesso (default-binding: POST).
      assertion_consumer_service_url: sso_url,
      # Indirizzo a cui l'dentity provider chiama una volta che l'utente ha effettuato il logout (default-binding: Redirect).
      single_logout_service_url: slo_url,
      # Richiedi firma all'IDP
      # TODO: La firma non viene controllata
      security: { want_assertions_signed: true }
    }
  end

  def idp_attributes
    parser = OneLogin::RubySaml::IdpMetadataParser.new
    parser.parse_remote_to_hash idp_xml(params[:idp]),
                                true,
                                sso_binding: bindings(params[:request_types])
  end

  def sso_attributes
    sso_attributes = sp_attributes.merge(idp_attributes)
    sso_attributes[:authn_context] = authn_context
    sso_attributes[:authn_context_comparison] = 'minimum'
    sso_attributes
  end

  def slo_attributes
    slo_attributes = sso_attributes
    slo_attributes[:sessionindex] = session[:index]
    slo_attributes
  end

  def bindings request_types
    request_types ||= ['redirect']
    formatted_type = request_types.map do |type|
      type = 'POST' if type == 'post'
      type = 'Redirect' if type == 'redirect'
      "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-#{type}"
    end
  end

  # Impost il livello di autorizzazione
  # livello 1 base
  # livello 2 sms
  def authn_context
    "https://www.spid.gov.it/SpidL#{params[:spid_level] || 1}"
  end

  def idp_xml idp
    case idp
    when :test
      main_app.root_url + 'metadata-idp-test-local.xml'
    when :poste
      'http://spidposte.test.poste.it/jod-fs/metadata/idp.xml'
    else
      main_app.root_url + 'metadata-idp-gov.xml'
    end
  end

end
