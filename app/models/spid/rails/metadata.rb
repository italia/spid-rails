module Spid
  module Rails

    class Metadata
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
