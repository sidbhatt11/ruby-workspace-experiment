# frozen_string_literal: true

require 'sorbet-runtime'
require_relative './workspace'

task default: %w[run]

def arguments
  args = ARGV.to_a
  
  args_hash = {
    first: args[1],
    rest: args.slice(2..-1)
  }

  args_hash.each do |k, v|
    args_hash.define_singleton_method(k, ->() { v })
  end

  args_hash
end

task :run do
  Workspace::Core::Runner.run(arguments.first, arguments.rest)
end

task :test do
  Workspace::Core::Runner.test(arguments.first, arguments.rest)
end

# Catch-all tasks
rule "" do
  # Do nothing
end