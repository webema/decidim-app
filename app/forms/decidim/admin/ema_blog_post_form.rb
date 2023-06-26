# frozen_string_literal: true

module Decidim
  module Admin
    # A form object used to create blog_posts from the admin
    # dashboard.

    class EmaBlogPostForm < Form
      include Decidim::HasUploadValidations

      mimic :ema_blog_post

      attribute :title, String
      attribute :body, String

      attribute :hero_image
      attribute :remove_hero_image, Boolean, default: false

      attribute :hide_hero_image, Boolean, default: false
      attribute :published, Boolean, default: true

      validates :title, presence: true
      validates :hero_image, passthru: { to: Ema::BlogPost }

      alias organization current_organization
    end
  end
end
