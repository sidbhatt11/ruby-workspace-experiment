# frozen_string_literal: true
# typed: false

require 'test/unit'

module Workspace
  module Apps
    module Greeter
      # Tests for Greeter App
      class GreeterTest < Test::Unit::TestCase
        def test_pass
          assert(true, 'dis must not fail')
        end
      end
    end
  end
end
