require_dependency "spid_rails/application_controller"

# Metadata del Service Provider
module SpidRails

  class MetadataController < ApplicationController

    def show
      metadata = SpidRails::Metadata.create(host: main_app.root_url)
      render xml: metadata.to_xml
    end

  end

end
