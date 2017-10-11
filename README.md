# spid-rails
SPID authentication for Ruby on Rails

# Lavoro effettuato

- Creazione gemma
- Applicazione demo funzionante con login tramite il server test idp.spid.gov.it
repository: https://github.com/rubynetti/rubynetti-rails

## Come si usa?
spid-rails è un gemma-engine che imposta il lavoro all'interno della path /spid/.
Una volta installata la gemma sarà possibile gestire serenamente il login tramite spid.


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

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
