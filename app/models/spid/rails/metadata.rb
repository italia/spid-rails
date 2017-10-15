module Spid
  module Rails

    class Metadata
      attr_accessor :settings

      def initialize **settings
        @settings = settings
      end

      def valid?
        raise 'EntityID deve essere presente (impostare issuer)' if settings[:issuer].blank?
        true
      end

      def save
        valid?
        metadata = OneLogin::RubySaml::Metadata.new
        saml_settings = OneLogin::RubySaml::Settings.new @settings
        @to_xml = metadata.generate(saml_settings)
        self
      end

      def to_xml
        save if @to_xml.blank?
        @to_xml
      end

      def self.create **settings
        obj = self.new(**settings)
        obj.save if obj.valid?
      end

      def self.xml_namespaces
        {
          saml: 'urn:oasis:names:tc:SAML:2.0:assertion',
          samlp: 'urn:oasis:names:tc:SAML:2.0:protocol',
          md: 'urn:oasis:names:tc:SAML:2.0:metadata',
          ds: 'http://www.w3.org/2000/09/xmldsig#',
          xenc: 'http://www.w3.org/2001/04/xmlenc#',
          xs: 'http://www.w3.org/2001/XMLSchema'
        }

      end
    end

  end
end
