# frozen_string_literal: true
# typed: false

module Workspace
  module Core
    # Provides magical powers to whoever needs it
    module Loadable
      # @param [String] dir_name - relative to the workspace root, where should we look for missing modules
      def relative_root(dir_name = '')
        @relative_root ||= dir_name
      end

      def const_missing(name)
        @looked_for ||= {}
        str_name = name.to_s
        raise "Not found: #{name}" if @looked_for[str_name]

        @looked_for[str_name] = 1
        require_relative "../#{relative_root}/#{str_name.downcase}/main.rb"

        klass = const_get(name)
        return klass if klass

        raise "Not found: #{name}"
      end
    end
  end
end
