require_dependency "spid/rails/application_controller"

# Metadata del Service Provider
module Spid
  module Rails

    class MetadataController < ApplicationController

      def show
        metadata = Metadata.create(host: main_app.root_url)
        render xml: metadata.to_xml
      end

    end

  end
end
