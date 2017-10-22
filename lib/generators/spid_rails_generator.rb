# TODO: cambiare in rails g spid:config
class SpidRailsGenerator < Rails::Generators::Base

  source_root File.expand_path("../templates", __FILE__)

  desc "Crea il file di configurazione di spid (config/initializers/rumby_saml.rb)."

  def create_initializer_file
    template "spid_rails.rb",
              Rails.root + "config/initializers/spid_rails.rb"
  end

end
