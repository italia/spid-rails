require 'onelogin/ruby-saml'
require 'spid-rails/onelogin/rubysaml/authrequest'

module Spid
  module Rails

    class Engine < ::Rails::Engine
      initializer 'spid_rails_engine' do |_app|
        ActionView::Base.send :include, ::Spid::Rails::RouteHelper
      end

    end

  end
end
