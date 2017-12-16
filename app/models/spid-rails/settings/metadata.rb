module Spid
  module Rails

    class Settings::Metadata < Settings

      def to_hash
        sp_attributes
      end

    end

  end
end
