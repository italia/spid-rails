class Spid::Rails::SpidController < ApplicationController

  private

  def saml_settings
    parser = OneLogin::RubySaml::IdpMetadataParser.new

    settings = parser.parse_remote idp_xml(:gov),
                                   true,
                                   sso_binding: [binding(:redirect)]

    settings.issuer        = metadata_url
    settings.authn_context = authn_context
    settings.authn_context_comparison = 'minimum'

    settings.sessionindex = session[:index]

    settings
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
