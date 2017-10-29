module SpidRails

  class Settings::Request < Settings

    def to_hash
      sso_attributes = sp_attributes.merge(idp_attributes)
      sso_attributes[:authn_context] = authn_context
      sso_attributes[:authn_context_comparison] = 'minimum'
      sso_attributes[:force_authn] = force_authn
      sso_attributes[:protocol_binding] = saml_bindings[:post]
      sso_attributes
    end

  end

end
