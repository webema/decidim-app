# frozen_string_literal: true

module Decidim
  # A command with all the business logic when a user creates a report.
  class CreateBlogPost < Decidim::Command
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

      blog_post = Ema::BlogPost.new(attributes)

      if blog_post.valid?
        blog_post.save!
        broadcast(:ok)
      else
        form.errors.add(:hero_image, blog_post.errors[:hero_image]) if blog_post.errors.include? :hero_image
        broadcast(:invalid)
      end
    end

    private

    attr_reader :form, :blog_post

    def attributes
      {
        title: form.title,
        body: form.body,
        organization: form.current_organization
      }.merge(
        attachment_attributes(:hero_image)
      )
    end
  end
end