module Spid
  module Rails

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


      # TODO: defaults
      def initialize kwargs
        @metadata_path  = Spid::Rails.app_metadata_path
        @sso_path       = Spid::Rails.app_sso_path
        @slo_path       = Spid::Rails.app_slo_path
        @keys_path      = Spid::Rails.keys_path
        @sha            = Spid::Rails.sha
        @idp            = :gov
        @bindings       = [:redirect]
        @spid_level     = 1
        kwargs.each do |k, v|
          send("#{k}=", v)
        end
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
          issuer: host + metadata_path,
          assertion_consumer_service_path: host + sso_path,
          single_logout_service_path: host + slo_path,
          private_key: File.read("#{keys_path}/private_key.pem"),
          certificate: File.read("#{keys_path}/certificate.pem"),
          security: security_attributes
        }
      end

      def idp_attributes
        parser = OneLogin::RubySaml::IdpMetadataParser.new
        parser.parse_remote_to_hash Idp.metadata_urls(@idp),
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
