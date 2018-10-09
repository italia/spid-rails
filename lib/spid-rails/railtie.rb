# frozen_string_literal: true

module Spid
  module Rails
    class Railtie < ::Rails::Railtie # :nodoc:
      rake_tasks do |_app|
        require 'spid/tasks'
      end
    end
  end
end
