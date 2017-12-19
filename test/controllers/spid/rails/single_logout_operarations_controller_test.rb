require 'test_helper'

module Spid
  module Rails

    class SingleLogoutOperationsControllerTest < ActionDispatch::IntegrationTest
      include Engine.routes.url_helpers

      setup do
        @routes = Engine.routes
        get spid_rails.new_sso_url(sso: { idp: :poste_test })
      end

      test "get new slo" do
        get spid_rails.new_slo_url()
        assert_response :redirect
      end

      test "create slo" do
        get spid_rails.new_slo_url
        post spid_rails.slo_url('SAMLResponse' => File.read('test/templates/logout_response'))
        assert_response :redirect
        # TODO: verificare come usare main_app in test
        assert_redirected_to '/'
      end

    end

  end
end
