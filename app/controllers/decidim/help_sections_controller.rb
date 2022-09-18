# frozen_string_literal: true

module Decidim
  # This controller serves static pages using HighVoltage.
  class HelpSectionsController < Decidim::ApplicationController
    include ParticipatorySpaceContext

    helper Decidim::SanitizeHelper

    def show
      @content = help_section[current_locale]

      render layout: nil
    end

    private

    def help_section
      @help_section ||= Decidim::ContextualHelpSection.find_content(
        current_organization,
        help_id
      )
    end

    def help_id
      params[:id]
    end
  end
end
