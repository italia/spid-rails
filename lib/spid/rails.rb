require "spid/rails/engine"

module Spid
  module Rails

    # Mount point di Spid sull'applicazione
    mattr_accessor :mount_point
    @@mount_point = 'spid'

    # Url alla quale è disponibile il metadata del provider
    mattr_accessor :metadata_path
    @@metadata_path = 'metadata'

    # Url alla quale ricevere le risposte di autenticazione Saml
    mattr_accessor :sso_path
    @@sso_path = 'sso'

    # Url alla quale ricevere le risposte di logout Saml
    mattr_accessor :slo_path
    @@slo_path = 'slo'

    # Percorso relativo alla root dell'app
    # al quale reperire la coppia chiave privata - certificato
    mattr_accessor :keys_path
    @@keys_path = 'lib/.keys/'

    # Livello di crittografia SHA per la generazione delle signature
    mattr_accessor :sha
    @@sha = 256

    def self.app_metadata_path
      "#{mount_point}/#{@@metadata_path}"
    end

    def self.app_sso_path
      "#{mount_point}/#{@@sso_path}"
    end

    def self.app_slo_path
      "#{mount_point}/#{@@slo_path}"
    end

  end
end
