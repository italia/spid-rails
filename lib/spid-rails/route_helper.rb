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
    end
  end
end
