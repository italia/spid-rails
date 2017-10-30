module SpidRails

  class Settings::Sso < Settings

    def to_hash
      sso_attributes = sp_attributes.merge(idp_attributes)
      sso_attributes[:authn_context] = authn_context
      sso_attributes[:authn_context_comparison] = 'minimum'
      sso_attributes[:force_authn] = force_authn
      sso_attributes[:protocol_binding] = self.class.saml_bindings[:post]
      sso_attributes[:relay_state] = relay_state
      sso_attributes
    end

  end

end
