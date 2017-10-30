require 'test_helper'

module SpidRails

  class SingleSignOnsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
    end

    # TODO: implementare vcr
    test "get new sso" do
      get new_sso_url(sso: { idp: :poste } )
      assert_response :redirect
    end

    test "create sso" do
      get new_sso_url(sso: { idp: :poste } )
      post sso_url('SAMLResponse' => File.read('test/templates/authn_response'))
      assert_redirected_to '/'
    end

  end

end
