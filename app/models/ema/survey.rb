# frozen_string_literal: true

module Ema
  class Survey < ApplicationRecord
    self.table_name = 'ema_surveys'

    FORMULARE_E_URL = 'https://www.formulare-e.de/f/'.freeze

    include Decidim::HasAttachments
    include Decidim::HasUploadValidations
    include ::Decidim::AttachmentAttributesMethods

    has_one_attached :hero_image
    validates_upload :hero_image, uploader: Decidim::BlogPostHeroImageUploader

    belongs_to :organization, foreign_key: :decidim_organization_id, class_name: 'Decidim::Organization'

    validates :title, :url, presence: true
    validate :endpoint, if: :url_changed?
    # validate :availability, if: :url_changed?

    private

    def formulare_e_url?
      url.include?(FORMULARE_E_URL)
    end

    def availability
      return unless url.present?
      open(url).status = 200
    rescue
      errors.add(:url, 'Formular nicht verfügbar')
    end

    def endpoint
      return if formulare_e_url?
      errors.add(:url, 'ist keine Formulare-e-URL')
    end
  end
end
