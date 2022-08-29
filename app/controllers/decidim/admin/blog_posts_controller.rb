# frozen_string_literal: true

module Decidim
  module Admin
    class BlogPostsController < Decidim::Admin::ApplicationController
      helper Decidim::PaginateHelper
      layout 'decidim/admin/blog_posts'

      def index
        @blog_posts = blog_posts_for_organization.order(created_at: :desc).page(params[:page]).per(2)
      end

      def show
        @blog_post = blog_posts_for_organization.find(params[:id])
      end

      def new
        @form = form(EmaBlogPostForm).instance
      end

      def create
        @form = form(EmaBlogPostForm).from_params(params)

        CreateBlogPost.call(@form) do
          on(:ok) do
            redirect_to posts_path
          end

          on(:invalid) do
            render :new, status: :unprocessable_entity
          end
        end
      end

      def edit
        blog_post = blog_posts_for_organization.find(params[:id])
        @form = form(EmaBlogPostForm).from_model(blog_post)
      end

      def update
        @blog_post = blog_posts_for_organization.find(params[:id])
        @form = form(EmaBlogPostForm).from_params(params)

        UpdateBlogPost.call(@form, @blog_post) do
          on(:ok) do
            redirect_to post_path(@blog_post)
          end

          on(:invalid) do
            render :edit, status: :unprocessable_entity
          end
        end
      end

      def destroy
        @blog_post = blog_posts_for_organization.find(params[:id])
        @blog_post.destroy!
        redirect_to blog_posts_path
      end

      private

      def blog_post_params
        params[:ema_blog_post].to_unsafe_h
        # params.require(:ema_blog_post).permit(:title, :body)
      end

      def blog_posts_for_organization
        @blog_posts_for_organization ||= Ema::BlogPost.where(organization: current_organization)
      end
    end
  end
end