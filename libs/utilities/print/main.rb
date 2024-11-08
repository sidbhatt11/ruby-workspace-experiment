# frozen_string_literal: true
# typed: false

module Workspace
  module Libs
    module Utilities
      # Contains printing logic
      module Print
        def self.message(some_message = '')
          puts some_message
        end
      end
    end
  end
end
