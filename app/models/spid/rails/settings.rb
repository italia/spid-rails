module Spid
  module Rails

    class Settings
      attr_accessor :issuer
      attr_accessor :metadata_url
      attr_accessor :sso_url
      attr_accessor :slo_url
      attr_accessor :keys_path
      attr_accessor :sha

      # TODO: defaults
      def initialize **kwargs
        @issuer = kwargs[:metadata_url]
        @sso_url = kwargs[:sso_url]
        @slo_url = kwargs[:slo_url]
        @keys_path = kwargs[:keys_path]
        @sha = kwargs[:sha]
      end

      def to_hash
        {
          issuer: issuer,
          assertion_consumer_service_url: sso_url,
          single_logout_service_url: slo_url,
          # TODO: TUTTO IN CHIAROOOOOOOOOOOO AHAHAHAHAAAAAAAAAH
          private_key: File.read("#{keys_path}/private_key.pem"),
          certificate: File.read("#{keys_path}/certificate.pem"),
          security: security
        }
      end

      def security
        dig_alg = Spid::Rails::Certificate.digest_algorithm(@sha)
        sig_alg = Spid::Rails::Certificate.signature_algorithm(@sha)
        {
          metadata_signed: true,
          digest_method: dig_alg,
          signature_method: sig_alg,
          want_assertions_signed: true
        }
      end

    end

  end
end
