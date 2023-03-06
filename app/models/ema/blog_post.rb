# frozen_string_literal: true

module Ema
  class BlogPost < ApplicationRecord
    self.table_name = 'ema_blog_posts'

    include Decidim::HasAttachments
    include Decidim::HasAttachmentCollections
    include Decidim::HasUploadValidations
    include ::Decidim::AttachmentAttributesMethods
    include Decidim::Comments::Commentable

    has_one_attached :hero_image
    validates_upload :hero_image, uploader: Decidim::BlogPostHeroImageUploader

    belongs_to :organization, foreign_key: :decidim_organization_id, class_name: 'Decidim::Organization'

    validates :title, presence: true

    scope :published, -> {
      where(published: true)
    }

    def commentable?
      true
    end

    def root_commentable
      true
    end

    def comments_have_votes?
      true
    end

    def mounted_engine
      'ema_blog'
    end

    def mounted_params
      { host: 'localhost', id: id}
    end

    def resource_manifest
      Ema::Blog::ResourceManifest.new
    end
  end
end
