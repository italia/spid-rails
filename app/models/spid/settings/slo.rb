module Spid

  class Settings::Slo < Settings

    def to_hash
      sso_attributes = sp_attributes.merge(idp_attributes)
      sso_attributes[:sessionindex] = @session_index
      sso_attributes
    end

  end

end
