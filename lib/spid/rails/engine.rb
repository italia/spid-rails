require 'haml-rails'
require 'onelogin/ruby-saml'

module Spid
  module Rails
    class Engine < ::Rails::Engine
      isolate_namespace Spid::Rails
    end
  end
end
