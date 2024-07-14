# frozen_string_literal: true
# typed: true

require 'sorbet-runtime'

# Workspace module contains all the libs and apps, lazily loaded
module Workspace
  extend T::Sig

  module Core
    autoload(:Loadable, './core/loadable')
    autoload(:Runnable, './core/runnable')
    autoload(:Runner, './core/runner')
  end

  module Apps
    extend Core::Loadable

    relative_root './apps'
  end

  module Libs
    extend Core::Loadable

    relative_root './libs'
  end
end
