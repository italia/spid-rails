module Spid

  class Metadata
    attr_accessor :settings

    def self.create **settings
      obj = self.new(**settings)
      obj.save if obj.valid?
    end

    def initialize spid_params
      spid_settings = Settings::Metadata.new(spid_params)
      @settings = spid_settings.to_hash
    end

    def valid?
      raise 'EntityID deve essere presente (impostare issuer)' if settings[:issuer].blank?
      raise 'Signature deve essere presente (impostare private_key)' if settings[:private_key].blank?
      raise 'Signature deve essere presente (impostare certificate)' if settings[:certificate].blank?
      validate_signature_encryption
      validate_digest_encryption
      validate_key_size

      true
    end

    def validate_signature_encryption
      signature_algorithms = Certificate.signature_algorithms
      if signature_algorithms.exclude?(settings[:security][:signature_method])
        raise 'Signature deve essere presente (impostare encryption sha a 256, 384, 512)'
      end
    end

    def validate_digest_encryption
      digest_algorithms = Certificate.digest_algorithms
      if digest_algorithms.exclude?(settings[:security][:digest_method])
        raise 'Signature deve essere presente (impostare encryption sha a 256, 384, 512)'
      end
    end

    def validate_key_size
      key = OpenSSL::PKey::RSA.new settings[:private_key]
      key_size = key.n.num_bytes * 8
      if key_size < 1024
        raise 'Signature deve essere presente (impostare una chiave di almeno a 1024 bit'
      end
    end

    def save
      valid?
      metadata = OneLogin::RubySaml::Metadata.new
      saml_settings = OneLogin::RubySaml::Settings.new @settings
      @to_xml = metadata.generate(saml_settings)
      self
    end

    def to_xml
      save and @to_xml
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
