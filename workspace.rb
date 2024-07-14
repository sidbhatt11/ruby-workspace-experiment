# frozen_string_literal: true
# typed: true

require 'sorbet-runtime'

# Workspace module contains all the libs and apps, lazily loaded
module Workspace
  extend T::Sig
  
  module Core
    autoload(:Runnable, './core/runnable')
    autoload(:Loader, './core/loader')
    autoload(:Runner, './core/runner')
  end
end
