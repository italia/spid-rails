require 'onelogin/ruby-saml'
require 'spid-rails/onelogin/rubysaml/authrequest'

module Spid
  module Rails

    class Engine < ::Rails::Engine
      isolate_namespace Spid::Rails
    end

  end
end
