# frozen_string_literal: true
# typed: true

module Workspace
  module Core
    # Loads and returns an App or a Lib constant
    class Loader
      class << self
        extend T::Sig

        sig { params(lib_name: String).returns(T::Boolean) }
        def load_lib(lib_name)
          load('libs', lib_name)
        end

        sig { params(app_name: String).returns(T::Boolean) }
        def load_app(app_name)
          load('apps', app_name)
        end

        def load_test(name)
          load('apps', name, 'test') || load('libs', name, 'test')
        end

        private

        sig { params(type: String, name: String, file_name: String).returns(T::Boolean) }
        def load(type, name, file_name = 'main')
          require_relative "../#{type}/#{name.downcase}/#{file_name}.rb"
          const_defined?(name.capitalize)
        end
      end
    end
  end
end
