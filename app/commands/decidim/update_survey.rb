# frozen_string_literal: true

module Decidim
  # A command with all the business logic when a user creates a report.
  class UpdateSurvey < Decidim::Command
    include ::Decidim::AttachmentAttributesMethods

    # Public: Initializes the command.
    #
    # form         - A form object with the params.
    # survey    - The survey to update.
    def initialize(form, survey)
      @form = form
      @survey = survey
    end

    # Executes the command. Broadcasts these events:
    #
    # - :ok when everything is valid, together with the report.
    # - :invalid if the form wasn't valid and we couldn't proceed.
    #
    # Returns nothing.
    def call
      return broadcast(:invalid) if form.invalid?
      return broadcast(:invalid) unless survey

      survey.assign_attributes(attributes)

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
        accept_button_text: form.accept_button_text,
        decline_button_text: form.decline_button_text,
        outro: form.outro,
        active: form.active,
        url: form.url,
      }.merge(
        attachment_attributes(:hero_image)
      )
    end
  end
end
