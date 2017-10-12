require 'test_helper'

module Spid::Rails
  class MetadataControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers
    
    test "the truth" do
      get metadata_path
      assert_response :ok
    end
  end
end
