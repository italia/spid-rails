module Spid

  class Idp

    def self.metadata_urls
      {
        'agid_test'  => 'http://localhost:3000/metadata-idp-gov.xml',
        'aruba'      => 'https://loginspid.aruba.it/metadata',
        'infocert'   => 'https://identity.infocert.it/metadata/metadata.xml',
        'namirial'   => 'https://idp.namirialtsp.com/idp/metadata',
        'poste'      => 'https://posteid.poste.it/jod-fs/metadata/metadata.xml',
        'poste_test' => 'http://spidposte.test.poste.it/jod-fs/metadata/idp.xml',
        'spiditalia' => 'https://spid.register.it/login/metadata',
        'sielte'     => 'https://identity.sieltecloud.it/simplesaml/metadata.xml',
        'tim'        => 'https://login.id.tim.it/spid-services/MetadataBrowser/idp',
        'testenv2'   => 'http://spid-testenv:8088/metadata'
      }
    end

  end

end
