# frozen_string_literal: true
# typed: true

module Workspace
  module Core
    # Runs a runnable
    class Runner
      class << self
        extend T::Sig

        sig { params(app_name: String, arguments: T::Array[String]).void }
        def run(app_name, arguments = [])
          raise "Could not find app #{app_name}" unless Loader.load_app(app_name)

          runnable_klass = const_get("#{app_name.capitalize}::Main")
          raise "#{runnable_klass} must be Runnable" unless runnable_klass < Runnable

          begin
            runnable_klass.new(arguments).post_init
          rescue NameError => e
            missing_thing = e.name.to_s
            retry if Loader.load_lib(missing_thing) else "Could not find #{missing_thing}. Giving up."
          end
        end

        sig { params(app_name: String, _arguments: T::Array[String]).void }
        def test(app_name, _arguments = [])
          raise "Could not find #{app_name} to test" unless Loader.load_test(app_name)
        end
      end
    end
  end
end
