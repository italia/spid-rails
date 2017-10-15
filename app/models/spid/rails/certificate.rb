module Spid
  module Rails

    class Certificate

      def self.signature_algorithmns
        [
          XMLSecurity::Document::RSA_SHA256,
          XMLSecurity::Document::RSA_SHA384,
          XMLSecurity::Document::RSA_SHA512,
        ]
      end

      def digest_algorithmns
        [
          XMLSecurity::Document::SHA256,
          XMLSecurity::Document::SHA384,
          XMLSecurity::Document::SHA512,
        ]
      end

    end

  end
end
