require 'test_helper'

module SpidRails

  class SingleSignOnsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
    end

    test "get new" do
      get new_sso_url(sso: { idp: :gov } )
      assert_response :redirect
    end

    test "get create" do
      post sso_url('SAMLResponse' => File.read('test/templates/authn_response'))
      assert_response :ok
    end

  end

end
