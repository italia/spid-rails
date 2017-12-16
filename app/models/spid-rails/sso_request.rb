module Spid
  module Rails

    class SsoRequest

      attr_accessor :settings

      def initialize spid_params
        spid_settings = SpidRails::Settings::Sso.new(spid_params)
        @settings = spid_settings.to_hash
      end

      def valid?
        if settings[:idp_sso_target_url].blank?
          raise "Destination deve essere presente (impostare idp_sso_target_url)"
        end
        if settings[:authn_context].last != '1' && settings[:force_authn] != true
          raise "ForceAuthn deve essere presente per livelli di aitenticazione diversi da SPIDL1 (impostare force_authn a true)"
        end
        if settings[:authn_context_comparison] != 'minimum'
          raise "AuthnContextComparison deve essere settato a 'minimum' (impostare authn_context_comparison a 'minimum')"
        end
        if settings[:protocol_binding] != SpidRails::Settings.saml_bindings[:post]
          raise "Issuer deve contenere l'attributo ProtocolBinding con binding POST (impostare protocl_binding a ':post')"
        end
      end

      def save
        valid?
        request = OneLogin::RubySaml::Authrequest.new
        saml_settings = OneLogin::RubySaml::Settings.new @settings
        @to_saml = request.create(saml_settings)
        self
      end

      def to_saml
        save and @to_saml
      end

      def self.create **settings
        obj = self.new(**settings)
        obj.save
      end

    end

  end
end
