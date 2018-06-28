module Spid

  class Settings

    attr_accessor :host

    attr_accessor :metadata_path

    attr_accessor :sso_path

    attr_accessor :slo_path

    attr_accessor :keys_path

    attr_accessor :sha

    attr_accessor :idp

    attr_accessor :bindings

    attr_accessor :spid_level

    attr_accessor :session_index

    attr_accessor :relay_state

    def initialize spid_params
      @metadata_path  = Spid::Rails.app_metadata_path
      @sso_path       = Spid::Rails.app_sso_path
      @slo_path       = Spid::Rails.app_slo_path
      @keys_path      = Spid::Rails.keys_path
      @sha            = Spid::Rails.sha
      @bindings       = [:redirect]
      @spid_level     = 1
      spid_params.each do |k, v|
        send("#{k}=", v)
      end
    end

    def security_attributes
      dig_alg = Certificate.digest_algorithm(@sha)
      sig_alg = Certificate.signature_algorithm(@sha)
      {
        metadata_signed: true,
        digest_method: dig_alg,
        signature_method: sig_alg,
        authn_requests_signed: true,
        want_assertions_signed: true
      }
    end

    def sp_attributes
      {
        issuer: host,
        assertion_consumer_service_url: host + sso_path,
        single_logout_service_url: host + slo_path,
        private_key: File.read("#{::Rails.root}/#{keys_path}/private_key.pem"),
        certificate: File.read("#{::Rails.root}/#{keys_path}/certificate.pem"),
        security: security_attributes
      }
    end

    def idp_attributes
      idp = Spid::Idp.find(@idp.to_s)
      bindings = @bindings.map { |verb| self.class.saml_bindings[verb] }
      parser = OneLogin::RubySaml::IdpMetadataParser.new
      parser.parse_remote_to_hash idp.metadata_url,
                                  idp.validate_cert?,
                                  sso_binding: bindings
    end

    private

    def authn_context
      "https://www.spid.gov.it/SpidL#{@spid_level}"
    end

    def force_authn
      return true if @spid_level != 1
    end

    # TODO spostare in utils
    def self.saml_bindings
      {
        post: 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST',
        redirect: 'urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect'
      }
    end

  end

end
