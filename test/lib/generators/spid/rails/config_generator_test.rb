require 'test_helper'
require 'generators/spid/rails/config_generator'

module Spid
  module Rails

    module Generators

      class ConfigGeneratorTest < ::Rails::Generators::TestCase
        tests ConfigGenerator
        destination ::Rails.root.join('../tmp/generators')
        setup :prepare_destination

        test 'generator create file without errors' do
          assert_nothing_raised do
            run_generator
            assert_file 'config/initializers/spid-rails.rb'
          end
        end
      end

    end

  end
end
