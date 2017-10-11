class Spid::Rails::SpidController < ApplicationController

  private

  def saml_settings
    idp_settings
  end

  def sp_settings
    settings = OneLogin::RubySaml::Settings.new sp_attributes
  end

  def sp_attributes
    {
      # Indirizzo del metadata del service provider: /spid/metadata.
      issuer: metadata_url
      # Indirizzo che l'identity provider chiama una volta che l'utente ha effettuato l'accesso (default-binding: POST).
      assertion_consumer_service_url: sso_url
      # Indirizzo a cui l'dentity provider chiama una volta che l'utente ha effettuato il logout (default-binding: Redirect).
      single_logout_service_url: = slo_url
      # Richiedi firma all'IDP
      # TODO: La firma non viene controllata
      security[:want_assertions_signed] => true
    }
  end

  def idp_settings
    settings = OneLogin::RubySaml::Settings.new idp_attributes.merge(sp_attributes)
    settings.authn_context = authn_context
    settings.authn_context_comparison = 'minimum'

    settings.sessionindex = session[:index]
    settings
  end

  def idp_attributes
    parser = OneLogin::RubySaml::IdpMetadataParser.new
    parser.parse_remote_to_hash idp_xml(:gov),
                                true,
                                sso_binding: [binding(:redirect)]
  end

  def binding request_type
    formatted_type = case request_type
    when :post;     'POST'
    when :redirect; 'Redirect'
    end
    "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-#{formatted_type}"
  end

  # Impost il livello di autorizzazione
  # livello 1 base
  # livello 2 sms
  def authn_context
    "https://www.spid.gov.it/SpidL#{params[:spid_level] || 1}"
  end

  def idp_xml idp = :test
    case idp
    when :gov
      main_app.root_url + 'metadata-idp-gov.xml'
    when :poste
      'http://spidposte.test.poste.it/jod-fs/metadata/idp.xml'
    when :test
      main_app.root_url + 'metadata-idp-test-local.xml'
    end
  end

end
