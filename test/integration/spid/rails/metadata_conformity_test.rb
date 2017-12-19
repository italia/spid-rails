require 'test_helper'

module Spid
  module Rails

    # Testa conformità a regole tecniche disponibili a
    # http://spid-regole-tecniche.readthedocs.io/en/latest/regole-tecniche-sp.html#metadata
    class MetadataConformityTest < ActionDispatch::IntegrationTest
      include Engine.routes.url_helpers

      setup do
        @routes = Engine.routes
        @namespaces = Metadata.xml_namespaces
        @allowed_signature_algorithms = Certificate.signature_algorithms
        @allowed_digest_algorithms = Certificate.digest_algorithms
        get metadata_url
        @metadata = css_select('*')
      end

      # Conformità EntityDescriptor
      test "conformità EntityDescriptor" do
        node = @metadata.at_xpath("//md:EntityDescriptor")
        assert node.present?
        assert node.attr('ID').present?
        assert node.attr('entityID').present?
      end

      # Conformità KeyDescriptor
      test "conformità KeyDescriptor" do
        node = @metadata.at_xpath("//md:KeyDescriptor")
        assert node.present?

        signature_node = node.at_xpath("//ds:Signature", @namespaces)
        assert signature_node.present?

        certificate_node = node.at_xpath("//ds:X509Certificate", @namespaces)
        assert certificate_node.present?
      end

      # Conformità KeyDescriptor - Signature
      test 'conformità signature' do
        signature_value_node = @metadata.at_xpath("//ds:Signature/ds:SignatureValue",
                                              @namespaces)
        signature = signature_value_node.text
        assert signature.present?


        signature_method_node = @metadata.at_xpath("//ds:Signature//ds:SignatureMethod",
                                                    @namespaces)
        algorithm = signature_method_node.attribute('Algorithm').value
        assert_includes @allowed_signature_algorithms, algorithm


        signature_digest_node = @metadata.at_xpath("//ds:Signature//ds:DigestMethod",
                                                    @namespaces)
        algorithm = signature_digest_node.attribute('Algorithm').value
        assert_includes @allowed_digest_algorithms, algorithm
      end

      test 'conformità certificato' do
        certificate_node = @metadata.at_xpath("//ds:X509Certificate", @namespaces)
        certificate = certificate_node.text
        assert certificate.present?
        certificate_obj = OpenSSL::X509::Certificate.new Base64.decode64(certificate)
        key_bytes_size = certificate_obj.public_key.n.num_bytes
        assert key_bytes_size * 8 >= 1024
      end

    end

  end
end
