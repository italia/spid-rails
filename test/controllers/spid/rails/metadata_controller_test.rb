require 'test_helper'

module Spid
  module Rails

    class MetadataControllerTest < ActionDispatch::IntegrationTest
      include Engine.routes.url_helpers

      setup do
        @routes = Engine.routes
      end

      test "get metadata url" do
        get metadata_url
        assert_response :success
      end

    end

  end
end
