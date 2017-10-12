# spid-rails 0.1.0
Autenticazione SPID per Ruby on Rails.  
Questa gemma si appoggia alla gemma [ruby-saml](https://github.com/onelogin/ruby-saml).

## Come si usa?
spid-rails è un gemma-engine che imposta il lavoro all'interno della path /spid/.

Una volta installata la gemma sarà possibile gestire il login tramite spid.


## Installazione

All'interno del Gemfile indicare questa gemma:

```ruby
gem 'spid-rails', git: 'git@github.com:rubynetti/spid-rails.git'
```

Eseguire
```bash
$ bundle
```
<!-- Or install it yourself as:
```bash
$ gem install spid-rails
``` -->

# Cosa c'è e cosa manca
- [x] Creazione gemma
- [x] Applicazione demo funzionante con login tramite il server test idp.spid.gov.it
repository: https://github.com/rubynetti/rubynetti-rails
- [x] Login tramite redirect
- [ ] Login tramite post
- [ ] Sistema di testing automatico - WIP
- [ ] Sistema di configurazione - WIP
- [ ] Test con certificati e server di identificazione (esempio poste)
- [ ] Integrazione con omniauth
- [ ] Integrazione o esempio di integrazione con devise

Qui è possibile seguire il progress dei lavori:
https://github.com/rubynetti/spid-rails/projects/1



## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
