module SpidRails

  class Settings::Request < Settings

    def to_hash
      sso_attributes = sp_attributes.merge(idp_attributes)
      sso_attributes[:authn_context] = authn_context
      sso_attributes[:authn_context_comparison] = 'minimum'
      sso_attributes
    end

  end

end
