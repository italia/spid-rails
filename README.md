# spid-rails [![Build Status](https://secure.travis-ci.org/italia/spid-rails.svg)](http://travis-ci.org/italia/spid-rails)
Autenticazione SPID per Ruby on Rails.
Questa gemma si appoggia alla gemma [ruby-saml](https://github.com/onelogin/ruby-saml).

## Cosa c'è e cosa manca
- [x] Creazione gemma
- [x] Applicazione demo funzionante con login tramite il server test idp.spid.gov.it
repository: https://github.com/rubynetti/rubynetti-rails
- [x] Login tramite redirect
- [ ] Login tramite post
- [X] Sistema di testing automatico
- [X] Sistema di configurazione
- [ ] Integrazione con omniauth
- [ ] Integrazione o esempio di integrazione con devise
- [X] Configurazione richiesta attributi utente


## Installazione
Aggiungere nel Gemfile
```ruby
gem 'spid-rails'
```
ed eseguire 

```bash
$ bundle
```


## Come si usa?
Questa gemma è un wrapper della gemma [spid-ruby](https://github.com/italia/spid-ruby) con funzionalità per semplificare l'utilizzo con rails


### Configurazione

Per creare il file di configurazione:

```bash
$ rails g spid:rails:config
```
che creerà il file din configurazione `config/initializer/spid-rails.rb` con la configurazione default

### Helpers
La gemma fornirà una serie di helpers per la generazione dei paths:

#### spid_login_path
`spid_login_path(idp_name: idp_entity_id, authn_context: Spid::L1, attribute_service_index: 0)`

che genera un url per iniziare il processo di autenticazione con un identity provider: 

* idp_name: Obbligatorio, è l'entity_id dell'IdP con cui vogliamo instaurare l'autenticazione
* authn_context: E' il valore del tipo di autenticazione richiesta. Default: `https://www.spid.gov.id/L1`
*attribute_service_index: Nel caso in cui l'applicazione disponga di più `AttributeConsumingService`, l'indice del servizio che vogliamo utilizzare. Default: 0

#### spid_logout_path
`spid_logout_path(idp_name: idp_entity_id)`
Come sopra, crea un link per iniziare il processo di logout verso l'IdP

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

