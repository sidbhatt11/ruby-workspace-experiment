# frozen_string_literal: true
# typed: false

# Contains Greeter application logic
module Workspace
  module Apps
    # Contains greeter app logic
    module Greeter
      # does simple printing
      class Main < Workspace::Core::Runnable
        after_init :greet

        def initialize(messages) # rubocop:disable Lint/MissingSuper
          @messages = messages
        end

        def greet
          Libs::Utilities::Print.message @messages.join(' ')
        end
      end
    end
  end
end
