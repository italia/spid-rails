module SpidRails

  class Idp

    def self.metadata_urls
      {
        'test'  => 'http://localhost:3000/metadata-idp-test-local.xml',
        'poste' => 'http://spidposte.test.poste.it/jod-fs/metadata/idp.xml',
        'gov'   => 'http://localhost:3000/metadata-idp-gov.xml'
      }
    end

  end

end
