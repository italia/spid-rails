module Spid
  module Rails

    module Generators

      class IdpImporterGenerator < ::Rails::Generators::Base

        source_root File.expand_path("templates", __dir__)

        desc "Crea il file di import custom degli Idp (config/spid-rails/idp_import.yml)."

        def create_import_file
          template "idp_import.yml", "./config/spid-rails/idp_import.yml"
        end

      end

    end

  end
end
