# frozen_string_literal: true

module Decidim
  module Admin
    # A form object used to create blog_posts from the admin
    # dashboard.

    class EmaSurveyForm < Form
      include Decidim::HasUploadValidations

      mimic :ema_survey

      attribute :title, String
      attribute :intro, String
      attribute :outro, String
      attribute :url, String
      attribute :active, Boolean

      attribute :hero_image
      attribute :remove_hero_image, Boolean, default: false

      validates :title, presence: true
      validates :url, presence: true

      validates :hero_image, passthru: { to: Ema::Survey }

      alias organization current_organization
    end
  end
end
