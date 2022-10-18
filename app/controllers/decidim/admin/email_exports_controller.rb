# frozen_string_literal: true

module Decidim
  module Admin
    class EmailExportsController < Decidim::Admin::ApplicationController
      # helper Decidim::PaginateHelper
      # layout 'decidim/admin/blog_posts'

      def index
        # @blog_posts = blog_posts_for_organization.order(created_at: :desc).page(params[:page]).per(2)
        # redirect_to root_url
      end


    end
  end
end
