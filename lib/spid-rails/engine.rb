require 'onelogin/ruby-saml'
require 'spid-rails/onelogin/rubysaml/authrequest'

module Spid
  module Rails

    class Engine < ::Rails::Engine
      isolate_namespace Spid::Rails

      initializer "spid-rails.load_custom_idp_list" do
        path_to_list = ::Rails.root.join("config", "spid-rails", "idp_import.yml")
        Spid::Idp.import(path_to_list) if File.exist?(path_to_list)
      end

    end

  end
end
