require 'test_helper'
require 'generators/spid/rails/idp_importer_generator'

module Spid
  module Rails

    module Generators

      class IdpImporterGeneratorTest < ::Rails::Generators::TestCase
        tests IdpImporterGenerator
        destination ::Rails.root.join('../tmp/generators')
        setup :prepare_destination

        test 'generator create file without errors' do
          assert_nothing_raised do
            run_generator
            assert_file 'config/spid-rails/idp_import.yml'
          end
        end
      end

    end

  end
end
