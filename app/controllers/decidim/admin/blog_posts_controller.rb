# frozen_string_literal: true

module Decidim
  module Admin
    class BlogPostsController < Decidim::Admin::ApplicationController
      helper Decidim::PaginateHelper
      layout 'decidim/admin/blog_posts'

      def index
        @blog_posts = Ema::BlogPost.all.order(created_at: :desc).page(params[:page]).per(2)
      end

      def show
        @blog_post = Ema::BlogPost.find(params[:id])
      end

      def new
        @blog_post = Ema::BlogPost.new
      end

      def create
        @blog_post = Ema::BlogPost.new(blog_post_params)

        if @blog_post.save
          redirect_to blog_post_path(@blog_post)
        else
          render :new, status: :unprocessable_entity
        end
      end

      def edit
        @blog_post = Ema::BlogPost.find(params[:id])
      end

      def update
        @blog_post = Ema::BlogPost.find(params[:id])

        if @blog_post.update(blog_post_params)
          redirect_to blog_post_path(@blog_post)
        else
          render :edit, status: :unprocessable_entity
        end
      end

      def destroy
        @blog_post = Ema::BlogPost.find(params[:id])
        @blog_post.destroy!
        redirect_to blog_posts_path
      end

      private

      def blog_post_params
        params.require(:ema_blog_post).permit(:title, :body)
      end
    end
  end
end




# def create
#   @content_element = @containable.content_elements.build(content_element_params.merge(type: type))
#   @content_element.position = 1 if content_element_params[:prepend]

#   if @content_element.save
#     analyze_images
#     render_editable_content_element
#   else
#     render :new, status: :unprocessable_entity
#   end
# end

# def edit
#   @content_element = @containable.content_elements.find(params[:id])
# end

# def update
#   @content_element = @containable.content_elements.find(params[:id])
#   if @content_element.update(update_content_element_params)
#     analyze_images
#     render_editable_content_element
#   else
#     render :edit, status: :unprocessable_entity
#   end
# end

# def destroy
#   @content_element = @containable.content_elements.find(params[:id])
#   @content_element.destroy!
#   head :ok
# end
