require 'onelogin/ruby-saml'
require 'spid_rails/onelogin/rubysaml/authrequest'

module SpidRails
  class Engine < ::Rails::Engine
    isolate_namespace SpidRails
  end
end
