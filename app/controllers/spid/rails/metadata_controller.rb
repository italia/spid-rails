require_dependency "spid/rails/application_controller"

# Metadata for Service Provider
class Spid::Rails::MetadataController < Spid::Rails::SpidController
  def show
    metadata = Spid::Rails::Metadata.create(sp_attributes)
    render xml: metadata.to_xml
  end
end
