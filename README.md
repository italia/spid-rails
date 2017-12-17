# spid-rails 0.1
Autenticazione SPID per Ruby on Rails.  
Questa gemma si appoggia alla gemma [ruby-saml](https://github.com/onelogin/ruby-saml).

## Cosa c'è e cosa manca
- [x] Creazione gemma
- [x] Applicazione demo funzionante con login tramite il server test idp.spid.gov.it
repository: https://github.com/rubynetti/rubynetti-rails
- [x] Login tramite redirect
- [ ] Login tramite post
- [ ] Sistema di testing automatico - WIP
- [X] Sistema di configurazione
- [ ] Integrazione con omniauth
- [ ] Integrazione o esempio di integrazione con devise


## Installazione
All'interno del Gemfile indicare questa gemma:

```ruby
gem 'spid-rails'
```

Eseguire

```bash
$ bundle
```


## Come si usa?
La gemma può essere aggiunta a qualunque applicazione Rails al fine di utilizzare il sistema di login Spid.
Il metadata generato può essere utilizzato per farsi accreditare e in seguito dialogare con qualunque Identity Provider Spid accreditato.


### Configurazione

Per creare il file di configurazione:

```bash
$ rails g spid-rails:config
```

Il file viene aggiunto agli initializer dell'applicazione e permette il settaggio personalizzato del mount-point dell'engine e i relativi end-point per le procedure Spid di login, logout e visualizzazione del metadata del Service Provider.

Le restanti impostazioni permettono di configurare il percorso di sistema dove reperire la coppia chiave privata/certificato e il livello di crittografia per l'eventuale signature.

```ruby
# config/initializers/spid-rails.rb

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
```


### Nelle view

Una volta installata la gemma, verranno creati una serie di helper utilizzabili nelle view e nei controller.

```spid_rails.metadata_path``` e ```spid_rails.metadata_url``` restituiscono il percorso al quale è reperibile il metadata del Service Provider.
```ruby
# Esempio di link al metadata del ServiceProvider
link_to "Metadata SP", spid_rails.metadata_path
```


```spid_rails.new_sso_path``` e ```spid_rails.new_sso_url``` restituiscono il percorso tramite il quale inizializzare una richiesa di autenticazione all'Identity Provider.
E' necessario fornire come parametro l'Idp cui indirizzare la richiesta, facoltativo il livello di autenticazione Spid (default: '1') e i bindings della richiesta all' Idp (default: ['redirect']).
```ruby
# Esempio di link al login tramite l'Idp di test https:://idp.spid.gov.it
link_to "Login con Spid", spid_rails.new_sso_path(sso: { idp: :agid_test, spid_level: 2 })
```

Gli Identity Provider attualmente supportati sono:
- 'aruba'      : servizio Idp di Aruba Pec S.p.A.
- 'infocert'   : servizio Idp di Infocert S.p.A
- 'namirial'   : servizio Idp di Namirial S.p.A.
- 'poste'      : servizio Idp di Poste Italiane S.p.A.
- 'spiditalia' : servizio Idp di REGISTER.IT S.p.A.
- 'sielte'     : servizio Idp di Sielte S.p.A.
- 'tim'        : servizio Idp di TI Trust Technologies S.r.l.
- 'agid_test'  : servizio idp di test di Agid
- 'poste_test' : servizio Idp di test di Poste Italiane S.p.A.


```spid_rails.new_slo_path``` e ```spid_rails.new_slo_url``` infine restituiscono il percorso tramite il quale inizializzare una richiesa di logout all'Identity Provider che ha autenticato la sessione corrente.
```ruby
# Esempio di link al logout
link_to "Logout", spid_rails.new_slo_path
```


### Nei controller

Avvenuta con successo l'autenticazione e fino al logout della stessa vengono aggiunte alla sessione le seguenti variabili:

```session[:sso_params]``` restituisce i parametri coi quali è stata effettuata l'ultima richiesta di autenticazione, in particolare l'idp

```session[:spid_index]```        restituisce l'identificativo dell'attuale sessione Spid, viene utilizzato nella procedura di logout

```session[:spid_login_time]``` l'istante in cui è avvenuto il login

E' inoltre possibile settare la variabile ```session[:spid_relay_state]```, contenente l'indirizzo al quale si vuole essere reindirizzati in caso l'autenticazione abbia successo

Un esempio rudimentale di verifica del login dell'utente all'interno di un'azione del controller potrebbe essere il seguente
```ruby
# app/controllers/my_controller.rb
class MyController < Application controller
  before_action :validate_spid_session

  ...

  private

  def validate_spid_session
    if session[:spid_index].blank?
      session[:spid_relay_state] = request.path
      redirect_to login_path
    end
  end

end
```
ove login_path indirizzi alla pagina in cui è posizionato il pulsante Spid


## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
