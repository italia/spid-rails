module Spid
  module Rails
    module RouteHelper
      def metadata_path
        Spid.configuration.metadata_path
      end

      def metadata_url
        URI.join(
          Spid.configuration.hostname,
          metadata_path
        ).to_s
      end

      def spid_login_path(
            idp_name:,
            authn_context: nil,
            attribute_service_index: nil
          )
        options = { idp_name: idp_name }
        options[:authn_context] = authn_context if authn_context.present?
        if attribute_service_index.present?
          options[:attribute_service_index] = attribute_service_index
        end
        [
          Spid.configuration.login_path,
          options.to_param
        ].join("?")
      end

      def spid_logout_path(idp_name:)
        options = { idp_name: idp_name }
        [
          Spid.configuration.logout_path,
          options.to_param
        ].join("?")
      end

      def spid_login_url(options)
        URI.join(
          Spid.configuration.hostname,
          spid_login_path(options)
        ).to_s
      end

      def spid_logout_url(options)
        URI.join(
          Spid.configuration.hostname,
          spid_logout_path(options)
        ).to_s
      end
    end
  end
end
