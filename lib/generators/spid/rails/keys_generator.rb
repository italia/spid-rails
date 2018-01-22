module Spid
  module Rails

    module Generators

      class KeysGenerator < ::Rails::Generators::Base
        class_option :cn, type: :string, default: 'spid-rails-test', desc: 'Common name for the X509 certificate'
        class_option :size, type: :numeric, default: 1024, desc: 'RSA key bit size'
        class_option :digest, type: :string, default: 'SHA256', desc: 'Digest algorithm for signing the certificate'
        class_option :validity, type: :numeric, default: 1, desc: "Certificate validity expressed in months"

        desc "Description:\n" +
            "  Generate a RSA key and use it to generate a self-signed certificate in the keys path\n" +
            "  WARNING: this generator is ment to be used only for testing purpose."

        def create_key
          @key = OpenSSL::PKey::RSA.new options[:size]
        end

        def create_certificate
          name = OpenSSL::X509::Name.parse "CN=#{options[:cn]}"
          sha_alg = OpenSSL::Digest.const_get(options[:digest]).new
          @cert = OpenSSL::X509::Certificate.new
          @cert.version = 2
          @cert.serial = 0
          @cert.not_before = Time.now
          @cert.not_after = @cert.not_before + options[:validity].months
          @cert.public_key = @key.public_key
          @cert.subject = name
          @cert.issuer = name
          @cert.sign @key, sha_alg
        end

        def write_keys
          path = './' + Spid::Rails.keys_path
          create_file path + 'private_key.pem', @key.to_pem
          create_file path + 'certificate.pem', @cert.to_pem
        end

      end

    end

  end
end
