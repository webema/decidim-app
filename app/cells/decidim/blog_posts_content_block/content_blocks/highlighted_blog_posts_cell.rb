# frozen_string_literal: true

module Decidim
  module BlogPostsContentBlock
    module ContentBlocks
      class HighlightedBlogPostsCell < Decidim::ViewModel
        include Decidim::ApplicationHelper # html_truncate
        # include Decidim::LayoutHelper # If icons are needed in the (customized) view
        include Decidim::SanitizeHelper # decidim_sanitize

        delegate :current_organization, to: :controller
        delegate :current_user, to: :controller

        def show
          render
        end

        def highlighted_blog_posts
          Ema::BlogPost.where(organization: current_organization).order(created_at: :desc).limit(4)
        end

        def i18n_scope
          "decidim.process_groups_content_block.pages.home.highlighted_process_groups"
        end

        private

        def body_for(post)
          decidim_sanitize(html_truncate(post.body, length: 100))
        end
      end
    end
  end
end
