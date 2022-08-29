# frozen_string_literal: true

module Decidim
  module ZukunftsprozessContentBlock
    module ContentBlocks
      class StartpageCell < Decidim::ViewModel
        include Decidim::ApplicationHelper # html_truncate
        # include Decidim::LayoutHelper # If icons are needed in the (customized) view
        include Decidim::SanitizeHelper # decidim_sanitize

        delegate :current_organization, to: :controller
        delegate :current_user, to: :controller

        def show
          render
        end

        def recent_blog_post
          Ema::BlogPost.where(organization: current_organization).order(created_at: :desc).first
        end


        private

        # def body_for(post)
        #   decidim_sanitize(html_truncate(post.body, length: 100))
        # end
      end
    end
  end
end