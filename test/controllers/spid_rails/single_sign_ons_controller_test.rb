require 'test_helper'

module SpidRails

  class SingleSignOnsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
    end

    # TODO: sistemare con vcr e gov invece di poste
    # asserzione di redirect invece di success
    test "get new" do
      get new_sso_url(sso: { idp: :poste } )
      assert_response :redirect
    end

    test "get create" do
      get new_sso_url(sso: { idp: :poste } )
      post sso_url('SAMLResponse' => File.read('test/templates/authn_response'))
      assert_response :success
    end

  end

end
