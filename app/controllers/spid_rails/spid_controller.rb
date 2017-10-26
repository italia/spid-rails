class SpidRails::SpidController < ApplicationController

  private

  def metadata_settings
    {
      metadata_url: metadata_url,
      sso_url: sso_url,
      slo_url: slo_url,
      keys_path: Rails.root + 'lib/.keys/',
      sha: 256
    }
  end

  def sso_settings_new
    {
      host: main_app.root_url,
      metadata_path: metadata_path,
      sso_path: sso_path,
      slo_path: slo_path,
      keys_path: Rails.root + 'lib/.keys/',
      sha: 256,
      idp:  :gov,
      bindings: [:redirect],
      spid_level: 1
    }
  end

  def sso_settings
    spid_settings = SpidRails::Settings::Request.new(session[:sso_params])
    OneLogin::RubySaml::Settings.new(spid_settings.to_hash)
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
      # Indirizzo a cui l'dentity provider chiama una volta che l'utente ha effettuato il logout (defa  ult-binding: Redirect).
      single_logout_service_url: slo_url,



      private_key: Rails.root + 'lib/.keys/private_key.pem',
      certificate: Rails.root + 'lib/.keys/private_key.pem'
    }
  end

  def idp_attributes
    parser = OneLogin::RubySaml::IdpMetadataParser.new
    parser.parse_to_hash File.open(Rails.root+'public/metadata-idp-gov.xml'),
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
