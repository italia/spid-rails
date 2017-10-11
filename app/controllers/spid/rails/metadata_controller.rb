require_dependency "spid/rails/application_controller"

# Metadata for Service Provider
class Spid::Rails::MetadataController < Spid::Rails::SpidController
  def show
    metadata = OneLogin::RubySaml::Metadata.new
    xml = metadata.generate(sp_settings)
    render xml: xml
  end
end
