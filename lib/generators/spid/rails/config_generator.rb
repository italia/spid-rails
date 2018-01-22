module Spid
  module Rails

    module Generators

      class ConfigGenerator < ::Rails::Generators::Base

        source_root File.expand_path("../templates", __FILE__)

        desc "Crea il file di configurazione di spid (config/initializers/spid-rails.rb)."

        def create_initializer_file
          template "spid-rails.rb", "./config/initializers/spid-rails.rb"
        end

      end

    end

  end
end
