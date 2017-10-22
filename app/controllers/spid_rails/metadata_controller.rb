require_dependency "spid_rails/application_controller"

# Metadata del Service Provider
class SpidRails::MetadataController < SpidRails::SpidController
  def show
    metadata = SpidRails::Metadata.create(host: main_app.root_url)
    render xml: metadata.to_xml
  end

end
