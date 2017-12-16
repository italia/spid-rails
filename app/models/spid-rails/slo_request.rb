module Spid
  module Rails

    class SloRequest

      def initialize slo_params
        spid_settings = SpidRails::Settings::Slo.new(slo_params)
        @settings = spid_settings.to_hash
        @request = OneLogin::RubySaml::Logoutrequest.new
      end

      def uuid
        @request.uuid
      end

      def to_saml
        saml_settings = OneLogin::RubySaml::Settings.new(@settings)
        @request.create(saml_settings)
      end

    end

  end
end
