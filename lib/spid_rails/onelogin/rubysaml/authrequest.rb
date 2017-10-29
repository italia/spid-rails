# Necessario override della classe originaria della libreria,
# al fine di rendere conforme il nodo Issuer alle regole tecniche SPID,
# (aggiunte righe 32 e 33)

module OneLogin
  module RubySaml
    class Authrequest

      def create_xml_document(settings)
        time = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")

        request_doc = XMLSecurity::Document.new
        request_doc.uuid = uuid

        root = request_doc.add_element "samlp:AuthnRequest", { "xmlns:samlp" => "urn:oasis:names:tc:SAML:2.0:protocol", "xmlns:saml" => "urn:oasis:names:tc:SAML:2.0:assertion" }
        root.attributes['ID'] = uuid
        root.attributes['IssueInstant'] = time
        root.attributes['Version'] = "2.0"
        root.attributes['Destination'] = settings.idp_sso_target_url unless settings.idp_sso_target_url.nil?
        root.attributes['IsPassive'] = settings.passive unless settings.passive.nil?
        root.attributes['ProtocolBinding'] = settings.protocol_binding unless settings.protocol_binding.nil?
        root.attributes["AttributeConsumingServiceIndex"] = settings.attributes_index unless settings.attributes_index.nil?
        root.attributes['ForceAuthn'] = settings.force_authn unless settings.force_authn.nil?

        # Conditionally defined elements based on settings
        if settings.assertion_consumer_service_url != nil
          root.attributes["AssertionConsumerServiceURL"] = settings.assertion_consumer_service_url
        end
        #NameQualifier e Format da requisiti SPID
        if settings.issuer != nil
          issuer = root.add_element "saml:Issuer",{
            "NameQualifier" => settings.issuer,
            "Format" => 'urn:oasis:names:tc:SAML:2.0:nameid-format:entity'
          }
          issuer.text = settings.issuer
        end
        if settings.name_identifier_format != nil
          root.add_element "samlp:NameIDPolicy", {
              # Might want to make AllowCreate a setting?
              "AllowCreate" => "true",
              "Format" => settings.name_identifier_format
          }
        end

        if settings.authn_context || settings.authn_context_decl_ref

          if settings.authn_context_comparison != nil
            comparison = settings.authn_context_comparison
          else
            comparison = 'exact'
          end

          requested_context = root.add_element "samlp:RequestedAuthnContext", {
            "Comparison" => comparison,
          }

          if settings.authn_context != nil
            authn_contexts_class_ref = settings.authn_context.is_a?(Array) ? settings.authn_context : [settings.authn_context]
            authn_contexts_class_ref.each do |authn_context_class_ref|
              class_ref = requested_context.add_element "saml:AuthnContextClassRef"
              class_ref.text = authn_context_class_ref
            end
          end

          if settings.authn_context_decl_ref != nil
            authn_contexts_decl_refs = settings.authn_context_decl_ref.is_a?(Array) ? settings.authn_context_decl_ref : [settings.authn_context_decl_ref]
            authn_contexts_decl_refs.each do |authn_context_decl_ref|
              decl_ref = requested_context.add_element "saml:AuthnContextDeclRef"
              decl_ref.text = authn_context_decl_ref
            end
          end
        end

        request_doc
      end

    end
  end
end
