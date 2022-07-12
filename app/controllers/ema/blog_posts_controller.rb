# frozen_string_literal: true

module Ema
  class BlogPostsController < Decidim::ApplicationController

    helper Decidim::PaginateHelper

    def index
      @blog_posts = Ema::BlogPost.all.order(created_at: :desc).page(params[:page]).per(2)
    end

    def show
      @blog_post = Ema::BlogPost.find(params[:id])
    end
  end
end
