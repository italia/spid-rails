module Spid
  module Rails

    class SloResponse

      def initialize saml_response, slo_id, slo_params
        spid_settings = SpidRails::Settings::Slo.new(slo_params)
        settings = OneLogin::RubySaml::Settings.new(spid_settings.to_hash)
        @response = OneLogin::RubySaml::Logoutresponse.new(saml_response,
                                                           settings,
                                                           matches_request_id: slo_id)
      end

      def valid?
        @response.validate
      end

      def inspect
        @response.inspect
      end

      def errors
        @response.errors
      end

    end

  end
end
