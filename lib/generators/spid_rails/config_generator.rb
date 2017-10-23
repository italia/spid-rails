module SpidRails
  module Generators

    # Chiamato tramite rails g spid_rails:config
    class ConfigGenerator < Rails::Generators::Base

      source_root File.expand_path("../templates", __FILE__)

      desc "Crea il file di configurazione di spid (config/initializers/rumby_saml.rb)."

      def create_initializer_file
        template "spid_rails.rb", "./config/initializers/spid_rails.rb"
      end

    end

  end
end
