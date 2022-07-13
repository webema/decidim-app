# frozen_string_literal: true

module Ema
  class BlogPostsController < Decidim::ApplicationController

    helper Decidim::PaginateHelper

    def index
      @blog_posts = blog_posts_for_organization.order(created_at: :desc).page(params[:page]).per(2)
    end

    def show
      @blog_post = blog_posts_for_organization.find(params[:id])
    end

    private

    def blog_posts_for_organization
      @blog_posts_for_organization ||= Ema::BlogPost.where(organization: current_organization)
    end
  end
end
