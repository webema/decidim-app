# frozen_string_literal: true

module Decidim
  # A command with all the business logic when a user creates a report.
  class UpdateBlogPost < Decidim::Command
    include ::Decidim::AttachmentAttributesMethods

    # Public: Initializes the command.
    #
    # form         - A form object with the params.
    # blog_post    - The blog_post to update.
    def initialize(form, blog_post)
      @form = form
      @blog_post = blog_post
    end

    # Executes the command. Broadcasts these events:
    #
    # - :ok when everything is valid, together with the report.
    # - :invalid if the form wasn't valid and we couldn't proceed.
    #
    # Returns nothing.
    def call
      return broadcast(:invalid) if form.invalid?
      return broadcast(:invalid) unless blog_post

      blog_post.assign_attributes(attributes)

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
        hide_hero_image: form.hide_hero_image,
        published: form.published
      }.merge(
        attachment_attributes(:hero_image)
      )
    end
  end
end
