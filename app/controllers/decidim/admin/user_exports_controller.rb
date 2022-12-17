# frozen_string_literal: true

module Decidim
  module Admin
    class UserExportsController < Decidim::Admin::ApplicationController
      before_action :enforce_permission

      def index
        @count = users_for_export.count
      end

      def create
        send_data ExportUsers.new(users_for_export).call, filename: "decidim-users-#{Date.today}.csv"
      end

      private

      def users_for_export
        Decidim::User.confirmed
        .not_deleted
        .where(organization: @current_organization)
        .where.not(newsletter_notifications_at: nil)
        .order(id: :asc)
      end

      def enforce_permission
        enforce_permission_to :update, :organization
      end
    end
  end
end
