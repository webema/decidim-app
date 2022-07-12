# frozen_string_literal: true

module Ema
  class BlogPostsController < Decidim::ApplicationController

    helper Decidim::PaginateHelper

    def index
      @blog_posts = Ema::BlogPost.all.page(params[:page]).per(2)
    end

    def show
      # TODO
    end
  end
end
