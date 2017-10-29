module SpidRails

  class Settings::SloRequest < Settings

    def to_hash
      sso_attributes = sp_attributes.merge(idp_attributes)
      sso_attributes[:sessionindex] = @session_index
      sso_attributes
    end

  end

end
