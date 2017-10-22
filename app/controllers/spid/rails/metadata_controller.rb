require_dependency "spid/rails/application_controller"

# Metadata for Service Provider
class Spid::Rails::MetadataController < Spid::Rails::SpidController
  def show
    metadata = Spid::Rails::Metadata.create(host: main_app.root_url)
    render xml: metadata.to_xml
  end

end
