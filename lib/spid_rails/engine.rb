require 'haml-rails'
require 'onelogin/ruby-saml'

module SpidRails
  class Engine < ::Rails::Engine
    isolate_namespace SpidRails
  end
end
