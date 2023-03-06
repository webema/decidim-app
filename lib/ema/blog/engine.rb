# frozen_string_literal: true

require "decidim/core"

module Ema
  module Blog
    # Ema Blog Rails Engine.
    class Engine < ::Rails::Engine
      isolate_namespace Ema::Blog

      routes.draw do
        resources :posts, path: '/', controller: 'blog_posts', only: %i[index show], as: 'ema_blog_posts'

        # root to: "blog_posts#index"
      end
    end
  end
end
