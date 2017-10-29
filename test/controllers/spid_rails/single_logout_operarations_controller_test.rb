require 'test_helper'

module SpidRails

  class SingleLogoutOperationsControllerTest < ActionDispatch::IntegrationTest
    include Engine.routes.url_helpers

    setup do
      @routes = Engine.routes
    end

    test "get new slo" do
      get spid_rails.new_slo_url()
      assert_response :redirect
    end

    test "create slo" do
      post spid_rails.slo_url('SAMLResponse' => File.read('test/templates/logout_response'))
      assert_response :redirect
      # TODO: verificare come usare main_app in test
      assert_redirected_to '/welcome'
    end

  end

end
