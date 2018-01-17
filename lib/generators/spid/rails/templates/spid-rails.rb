# Impostazioni di default dello Spid Engine

Spid::Rails.tap do |config|

  # Mount point di Spid sull'applicazione
  # default: 'spid'
  # config.mount_point = 'spid'

  # Url alla quale è disponibile il metadata del provider
  # default: 'metadata'
  # config.metadata_path = 'metadata'

  # Url alla quale ricevere le risposte di autenticazione Saml
  # default: 'sso'
  # config.sso_path = 'sso'

  # Url alla quale ricevere le risposte di logout Saml
  # default: 'slo'
  # config.slo_path = 'slo'

  # Percorso relativo alla root dell'app
  # al quale reperire la coppia chiave privata - certificato
  # default: 'lib/.keys'
  # config.keys_path = 'lib/.keys/'

  # Livello di crittografia SHA per la generazione delle signature
  # default: 256
  # config.sha = 256

end
