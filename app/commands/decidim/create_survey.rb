# frozen_string_literal: true

module Decidim
  # A command with all the business logic when a user creates a report.
  class CreateSurvey < Decidim::Command
    include ::Decidim::AttachmentAttributesMethods

    # Public: Initializes the command.
    #
    # form         - A form object with the params.
    def initialize(form)
      @form = form
    end

    # Executes the command. Broadcasts these events:
    #
    # - :ok when everything is valid, together with the report.
    # - :invalid if the form wasn't valid and we couldn't proceed.
    #
    # Returns nothing.
    def call
      return broadcast(:invalid) if form.invalid?

      survey = Ema::Survey.new(attributes)

      if survey.valid?
        survey.save!
        broadcast(:ok)
      else
        form.errors.add(:url, survey.errors[:url]) if survey.errors.include? :url
        form.errors.add(:hero_image, survey.errors[:hero_image]) if survey.errors.include? :hero_image
        broadcast(:invalid)
      end
    end

    private

    attr_reader :form, :survey

    def attributes
      {
        title: form.title,
        intro: form.intro,
        outro: form.outro,
        active: form.active,
        url: form.url,
        organization: form.current_organization
      }.merge(
        attachment_attributes(:hero_image)
      )
    end
  end
end
