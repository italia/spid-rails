require 'test_helper'

class Spid::Rails::Test < ActiveSupport::TestCase
  test 'truth' do
    assert_kind_of Module, Spid::Rails
  end
end
