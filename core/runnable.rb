# frozen_string_literal: true
# typed: true

module Workspace
  module Core
    # Parent class of every executable logic
    class Runnable
      extend T::Sig

      class << self
        extend T::Sig

        # @example
        #
        #     class MyRunnable < Core::Runnable
        #         # This will be called automatically for you
        #         after_init :my_post_init_logic
        #
        #         def initialize(options)
        #           # custom logic here
        #         end
        #
        #         def my_post_init_logic
        #           # custom logic here
        #         end
        #     end
        sig { params(method_name: Symbol).void }
        def after_init(method_name)
          after_init_methods << method_name
        end

        private

        sig { returns(T::Array[Symbol]) }
        def after_init_methods
          @after_init_methods ||= []
        end
      end

      sig { params(_options: T::Array[String]).void }
      def initialize(_options)
        raise NotImplementedError, 'Runnable modules must implement #initialize(_options)'
      end

      def post_init
        methods = after_init_methods

        if methods.empty?
          raise 'Runnable classes must define a post-initialization method using #after_init class method'
        end

        methods.each do |method_name|
          send(method_name)
        end

        true
      end

      private

      sig { returns(T::Array[Symbol]) }
      def after_init_methods
        self.class.send(:after_init_methods)
      end
    end
  end
end
