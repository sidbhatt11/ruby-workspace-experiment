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
          runnable_klass = const_get("Workspace::Apps::#{app_name.capitalize}::Main")
          runnable_klass.new(arguments).post_init
        end

        sig { params(name: String, _arguments: T::Array[String]).void }
        def test(name, _arguments = [])
          dir_name = name.downcase

          tests_not_found = {
            apps: T.let(false, T::Boolean),
            libs: T.let(false, T::Boolean)
          }

          begin
            tests_not_found.each do |module_type, not_found|
              require_relative "../#{module_type}/#{dir_name}/test" unless not_found
            end
          rescue LoadError => e
            tests_not_found.each_key do |module_type|
              tests_not_found[module_type] = true if e.path.to_s.include? module_type.to_s
            end

            raise e if tests_not_found.values.all? { |v| v == true }

            retry
          end
        end
      end
    end
  end
end
