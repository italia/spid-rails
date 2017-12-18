module Spid

  class Certificate

    def self.signature_algorithm sha
      case sha.to_s
      when '256'
        XMLSecurity::Document::RSA_SHA256
      when '384'
        XMLSecurity::Document::RSA_SHA384
      when '512'
        XMLSecurity::Document::RSA_SHA512
      end
    end

    def self.digest_algorithm sha
      case sha.to_s
      when '256'
        XMLSecurity::Document::SHA256
      when '384'
        XMLSecurity::Document::SHA384
      when '512'
        XMLSecurity::Document::SHA512
      end
    end

    def self.signature_algorithms
      [
        XMLSecurity::Document::RSA_SHA256,
        XMLSecurity::Document::RSA_SHA384,
        XMLSecurity::Document::RSA_SHA512,
      ]
    end

    def self.digest_algorithms
      [
        XMLSecurity::Document::SHA256,
        XMLSecurity::Document::SHA384,
        XMLSecurity::Document::SHA512,
      ]
    end

  end

end
