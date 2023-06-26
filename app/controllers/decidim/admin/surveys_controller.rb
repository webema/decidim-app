# frozen_string_literal: true

module Decidim
  module Admin
    class SurveysController < Decidim::Admin::ApplicationController
      before_action :enforce_permission

      def show
        @form = form(EmaSurveyForm).from_model(survey_for_organization)
        @survey = survey_for_organization
      end

      def update
      end

      def create
        @form = form(EmaSurveyForm).from_params(params)

        CreateSurvey.call(@form) do
          on(:ok) do
            redirect_to :survey
          end

          on(:invalid) do
            render :show, status: :unprocessable_entity
          end
        end
      end

      def update
        @survey= survey_for_organization
        @form = form(EmaSurveyForm).from_params(params)

        UpdateSurvey.call(@form, @survey) do
          on(:ok) do
            redirect_to :survey
          end

          on(:invalid) do
            render :show, status: :unprocessable_entity
          end
        end
      end

      private

      def survey_params
        params[:ema_survey].to_unsafe_h
      end

      def survey_for_organization
        @survey_for_organization ||= Ema::Survey.find_or_initialize_by(organization: current_organization)
      end

      def enforce_permission
        enforce_permission_to :update, :organization
      end
    end
  end
end
