# frozen_string_literal: true

module Ema
  module Blog
    class BlogPostsController < Decidim::ApplicationController

      helper Decidim::PaginateHelper
      helper Decidim::Comments::CommentsHelper
      include Decidim::Paginable

      def index
        @blog_posts = blog_posts_for_organization.order(created_at: :desc).page(params[:page]).per(10)
      end

      def show
        @blog_post = blog_posts_for_organization.find(params[:id])
      end

      private

      def blog_posts_for_organization
        @blog_posts_for_organization ||= Ema::BlogPost.published.where(organization: current_organization)
      end
    end
  end
end
