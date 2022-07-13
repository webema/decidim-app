# frozen_string_literal: true

module Ema
  class BlogPost < ApplicationRecord
    self.table_name = 'ema_blog_posts'

    include Decidim::HasAttachments
    include Decidim::HasAttachmentCollections

    belongs_to :organization, foreign_key: :decidim_organization_id, class_name: "Decidim::Organization"


    validates :title, presence: true
  end
end
