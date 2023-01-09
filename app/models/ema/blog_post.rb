# frozen_string_literal: true

module Ema
  class BlogPost < ApplicationRecord
    self.table_name = 'ema_blog_posts'

    include Decidim::HasAttachments
    include Decidim::HasAttachmentCollections
    include Decidim::HasUploadValidations
    include ::Decidim::AttachmentAttributesMethods

    has_one_attached :hero_image
    validates_upload :hero_image, uploader: Decidim::BlogPostHeroImageUploader

    belongs_to :organization, foreign_key: :decidim_organization_id, class_name: 'Decidim::Organization'

    validates :title, presence: true

    scope :published, -> {
      where(published: true)
    }
  end
end
