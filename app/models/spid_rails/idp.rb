module SpidRails

  class Idp

    # TODO rifare tutto con hash
    def self.metadata_urls idp
      case idp.to_s
      when 'test'
        'http://localhost:3000/metadata-idp-test-local.xml'
      when 'poste'
        'http://spidposte.test.poste.it/jod-fs/metadata/idp.xml'
      else
        'http://localhost:3000/metadata-idp-gov.xml'
      end

    end

  end

end
