module Spid
  module Rails

    class Settings
      attr_accessor :issuer
      attr_accessor :metadata_url
      attr_accessor :sso_url
      attr_accessor :slo_url
      attr_accessor :keys_path
      attr_accessor :sha
      attr_accessor :idp
      attr_accessor :bindings
      attr_accessor :spid_level

      # TODO: defaults
      def initialize **kwargs
        @issuer = kwargs[:metadata_url]
        @sso_url = kwargs[:sso_url]
        @slo_url = kwargs[:slo_url]
        @keys_path = kwargs[:keys_path]
        @sha = kwargs[:sha]
        @idp = kwargs[:idp]
        @bindings = kwargs[:bindings]
        @spid_level = kwargs[:spid_level]
      end

      def security_attributes
        dig_alg = Spid::Rails::Certificate.digest_algorithm(@sha)
        sig_alg = Spid::Rails::Certificate.signature_algorithm(@sha)
        {
          metadata_signed: true,
          digest_method: dig_alg,
          signature_method: sig_alg,
          want_assertions_signed: true
        }
      end


      def sp_attributes
        {
          issuer: issuer,
          assertion_consumer_service_url: sso_url,
          single_logout_service_url: slo_url,
          private_key: File.read("#{keys_path}/private_key.pem"),
          certificate: File.read("#{keys_path}/certificate.pem"),
          security: security_attributes
        }
      end

      def idp_attributes
        parser = OneLogin::RubySaml::IdpMetadataParser.new
        parser.parse_remote_to_hash @idp,
                                    true,
                                    sso_binding: saml_bindings(@bindings)
      end

      private

      def authn_context
        "https://www.spid.gov.it/SpidL#{@spid_level}"
      end

      def saml_bindings request_types
        formatted_type = request_types.map do |type|
          type = type.to_s
          type = 'POST' if type == 'post'
          type = 'Redirect' if type == 'redirect'
          "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-#{type}"
        end
      end

    end

  end
end
