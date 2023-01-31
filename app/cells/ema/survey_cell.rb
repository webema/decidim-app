# frozen_string_literal: true

module Ema
  # This cell renders the author of a resource. It is intended to be used
  # below resource titles to indicate its authorship & such, and is intended
  # for resources that have a single author.
  class SurveyCell < Decidim::ViewModel
    include Decidim::SanitizeHelper

    def show
      return if data_consent_unanswered
      return unless current_survey.present?
      return if answered_surveys.include?(current_survey_id)
      render
    end

    private

    def cookies
      parent_controller.send(:cookies)
    end

    def data_consent_unanswered
      JSON.parse(cookies['decidim-consent']).keys.none?
    rescue
      true
    end

    def answered_surveys
      JSON.parse(cookies['decidim-answered-surveys'] || '[]')
    end

    def current_survey_id
      URI(current_survey.url).path.split('/').last
    end

    def iframe_tag
      tag.div(class: 'resizable-iframe-container') do
        tag.div(class: 'loading-indicator') do
          'Umfrage wird geladen...'
        end + tag.iframe(src: "#{current_survey.url}?iframe=true", id: 'myIframe', class: '')
      end
    end

    def current_survey
      Ema::Survey.find_by(organization: current_organization, active: true)
    end
  end
end
