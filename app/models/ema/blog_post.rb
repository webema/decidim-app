# frozen_string_literal: true

module Ema
  class BlogPost < ApplicationRecord
    self.table_name = 'ema_blog_posts'

    include Decidim::HasAttachments
    include Decidim::HasAttachmentCollections


    validates :title, presence: true
  end
end
