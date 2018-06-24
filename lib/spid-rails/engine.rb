require 'onelogin/ruby-saml'
require 'spid-rails/onelogin/rubysaml/authrequest'

module Spid
  module Rails

    class Engine < ::Rails::Engine
      isolate_namespace Spid::Rails

      initializer "spid-rails.load_custom_idp_list" do
        path_to_list = ::Rails.root.join("config", "spid-rails", "idp_list.yml")
        if File.exist?(path_to_list)
          Spid::Idp.import(::Rails.root.join("config", "spid-rails", "idp_list.yml"))
        end
      end

    end

  end
end
