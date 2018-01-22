require 'test_helper'
require 'generators/spid/rails/keys_generator'

module Spid
  module Rails

    module Generators

      class KeysGeneratorTest < ::Rails::Generators::TestCase
        tests KeysGenerator
        destination ::Rails.root.join('../tmp/generators')
        setup :prepare_destination

        test "generator runs without errors" do
          assert_nothing_raised do
            run_generator
          end
          assert_file 'lib/.keys/private_key.pem'
          assert_file 'lib/.keys/certificate.pem'
        end
      end

    end

  end
end
