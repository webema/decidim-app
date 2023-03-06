# frozen_string_literal: true

require "rails"
require "active_support/all"
require "decidim/core"

module Ema
  module Blog
    # Ema Blog Rails Engine.
    class Engine < ::Rails::Engine
      isolate_namespace Ema::Blog
    end
  end
end
