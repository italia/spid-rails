module Spid
  module Rails

    class SsoResponse

      def initialize saml_response, sso_params
        response = OneLogin::RubySaml::Response.new(saml_response)
        settings = SpidRails::Settings::Sso.new(sso_params)
        saml_settings = OneLogin::RubySaml::Settings.new(settings.to_hash)
        response.settings = saml_settings
        @response = response
      end

      def valid?
        @response.is_valid?
      end

      def inspect
        @response.inspect
      end

      def session_index
        @response.sessionindex
      end

      def errors
        @response.errors
      end

    end

  end
end
